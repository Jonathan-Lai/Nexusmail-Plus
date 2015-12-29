//
//  NPMailTableViewDatasource.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NPMailTableViewController;

@interface NPMailTableViewDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) NPMailTableViewController *tableViewController;
@property (nonatomic, strong) NSString *folder;

- (void)refresh;

@end
