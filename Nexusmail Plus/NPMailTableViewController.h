//
//  NPMailTableViewController.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWRevealViewController;

@interface NPMailTableViewController : UITableViewController

@property (nonatomic, weak) SWRevealViewController *revealViewController;

- (void)showInbox;
- (void)showSent;
- (void)showSpam;

@end
