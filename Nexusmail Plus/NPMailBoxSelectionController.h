//
//  MailBoxSelectionController.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-29.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NPMailTableViewController;
@class SWRevealViewController;

@interface NPMailBoxSelectionController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) NPMailTableViewController *mailTableViewController;
@property (nonatomic, weak) SWRevealViewController *revealViewController;

@end
