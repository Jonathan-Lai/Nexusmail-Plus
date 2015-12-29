//
//  NPViewEmailViewController.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-29.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPViewEmailViewController.h"
#import "NPDateFormatHelper.h"
#import "UIViewController+NPHelper.h"

#import <MailCore/MailCore.h>

@interface NPViewEmailViewController()

@property (nonatomic, strong) MCOIMAPSession *session;
@property (nonatomic, assign) MCOIMAPMessage *message;
@property (nonatomic, copy) NSString *messageFolder;
@property (nonatomic, copy) NSString *messageBody;

@end

@implementation NPViewEmailViewController

- (id)initWithSession:(MCOIMAPSession *)session message:(MCOIMAPMessage *)message messageFolder:(NSString *)messageFolder {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _session = session;
        _message = message;
        _messageFolder = messageFolder;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    MCOIMAPFetchParsedContentOperation *operation = [self.session fetchParsedMessageOperationWithFolder:self.messageFolder
                                                                                                    uid:self.message.uid];
    [operation start:^(NSError * error, MCOMessageParser * parser) {
        if (error && error.code != MCOErrorNone) {
            [self showErrorMessage:error.description];
        } else {
            self.messageBody = [parser plainTextBodyRenderingAndStripWhitespace:YES];
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidUnload {
    [self.session cancelAllOperations];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *text = nil;
    
    switch (row) {
        case 0:
            text = self.message.header.subject;
            break;
        case 1:
            text = [NSString stringWithFormat:@"From: %@", self.message.header.from.displayName];
            break;
        case 2:
            text = [NSString stringWithFormat:@"To: %@\nCC: %@\nBCC: %@\nDate: %@",
                                              [self _displayNamesFromAddresses:self.message.header.to],
                                              [self _displayNamesFromAddresses:self.message.header.cc],
                                              [self _displayNamesFromAddresses:self.message.header.bcc],
                                              [NPDateFormatHelper stringFromDate:self.message.header.date]];
            break;
        case 3:
            text = self.messageBody;
            break;
        default:
            break;
    }
    
    cell.textLabel.text = text;
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

#pragma mark - Private

- (NSString *)_displayNamesFromAddresses:(NSArray *)addresses {
    NSMutableString *ret = [NSMutableString stringWithFormat:@""];
    
    for (MCOAddress *address in addresses) {
        [ret appendString:address.displayName];
        if (address != addresses.lastObject) {
            [ret appendString:@", "];
        }
    }
    
    return [NSString stringWithString:ret];
}

@end
