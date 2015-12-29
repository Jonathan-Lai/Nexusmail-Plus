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
#import "NPViewEmailViewController.h"
#import "UIViewController+NPHelper.h"

#import <MailCore/MailCore.h>

static const CGFloat kCellHeight = 90.0f;

@interface NPMailTableViewDatasource()

@property (nonatomic, strong) NSArray<MCOIMAPMessage *> *messages;
@property (nonatomic, strong) MCOIMAPSession *inComingSession;

@end

@implementation NPMailTableViewDatasource

- (void)refresh {
    // If we don't have a incoming imap session or the user has changed create/recreate the incoming imap session
    if (!self.inComingSession || self.inComingSession.username != [sharedAppDelegate currentSessionUserID]) {
        self.inComingSession = [[MCOIMAPSession alloc] init];
        [self.inComingSession setHostname:@"mailservices.uwaterloo.ca"];
        [self.inComingSession setPort:993];
        [self.inComingSession setUsername:[sharedAppDelegate currentSessionUserID]];
        [self.inComingSession setPassword:[sharedAppDelegate currentSessionPassword]];
        [self.inComingSession setConnectionType:MCOConnectionTypeTLS];
    }
    
    // Cancel any previous operation
    [self.inComingSession cancelAllOperations];
    
    // Show loading indicator
    [self.tableViewController showLoading:YES];
    
    // Fetch all emails
    MCOIMAPMessagesRequestKind requestKind = MCOIMAPMessagesRequestKindHeaders;
    MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];
    MCOIMAPFetchMessagesOperation *fetchOperation = [self.inComingSession fetchMessagesOperationWithFolder:self.folder requestKind:requestKind uids:uids];
    [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
        // Stop loading indicator
        [self.tableViewController showLoading:NO];
        
        // Check if there was an error:
        if(error && error.code != MCOErrorNone) {
            NSLog(@"Error downloading message headers:%@", error);
            if (error.code == MCOErrorAuthentication) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NPViewEmailViewController *viewEmailController = [[NPViewEmailViewController alloc] initWithSession:self.inComingSession message:self.messages[indexPath.row] messageFolder:self.folder];
    [self.tableViewController.navigationController pushViewController:viewEmailController animated:YES];
}

@end
