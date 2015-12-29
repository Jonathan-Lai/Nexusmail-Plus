//
//  NPViewEmailViewController.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-29.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MailCore/MailCore.h>

@interface NPViewEmailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (id)initWithSession:(MCOIMAPSession *)session message:(MCOIMAPMessage *)message messageFolder:(NSString *)messageFolder;

@end
