//
//  MailBoxSelectionController.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-29.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPMailBoxSelectionController.h"
#import "NPMailTableViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface NPMailBoxSelectionController()

@end

@implementation NPMailBoxSelectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@@uwaterloo.ca", [sharedAppDelegate currentSessionUserID]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
            text = @"Inbox";
            break;
        case 1:
            text = @"Sent";
            break;
        case 2:
            text = @"Spam";
            break;
        case 3:
            text = @"";
            break;
        case 4:
            text = @"Log Out";
            break;
        default:
            break;
    }
    
    cell.textLabel.text = text;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRevealViewController *revealController = self.revealViewController;

    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            [self.mailTableViewController showInbox];
            break;
        case 1:
            [self.mailTableViewController showSent];
            break;
        case 2:
            [self.mailTableViewController showSpam];
            break;
        case 3:
            break;
        case 4:
            [sharedAppDelegate openLogin];
            break;
        default:
            break;
    }
    
    [revealController revealToggle:self];
}

@end
