//
//  NPMailTableViewDatasource.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "AppDelegate.h"
#import "NPMailTableViewDatasource.h"
#import "NPMailTableViewCell.h"
#import "NPMailTableViewController.h"

#import <MailCore/MailCore.h>

static const CGFloat kCellHeight = 90.0f;

@interface NPMailTableViewDatasource()

@property (nonatomic, strong) NSArray<MCOAbstractMessage *> *messages;

@end

@implementation NPMailTableViewDatasource

- (void)refresh {
    MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
    [session setHostname:@"mailservices.uwaterloo.ca"];
    [session setPort:993];
    [session setUsername:[sharedAppDelegate currentSessionUserID]];
    [session setPassword:[sharedAppDelegate currentSessionPassword]];
    [session setConnectionType:MCOConnectionTypeTLS];
    
    NSString *password = [sharedAppDelegate currentSessionPassword];
    NSString *userName = [sharedAppDelegate currentSessionUserID];
    
    MCOIMAPMessagesRequestKind requestKind = MCOIMAPMessagesRequestKindHeaders;
    NSString *folder = @"INBOX";
    MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];
    
    MCOIMAPFetchMessagesOperation *fetchOperation = [session fetchMessagesOperationWithFolder:folder requestKind:requestKind uids:uids];
    
    [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
        // Check if there was an error:
        if(error) {
            NSLog(@"Error downloading message headers:%@", error);
            if (error.code == 5) {
                [sharedAppDelegate handleInvalidUserCredentials];
            } else {
                [self.tableViewController showErrorMessage:error.description];
            }
        } else {
            self.messages = [[fetchedMessages reverseObjectEnumerator] allObjects];
            [self.tableViewController.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NPMailTableViewCell";
    NPMailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NPMailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setMessage:self.messages[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

@end
