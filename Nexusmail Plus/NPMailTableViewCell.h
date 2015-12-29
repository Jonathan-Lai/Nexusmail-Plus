//
//  NPMailTableViewCell.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCOIMAPMessage;

@interface NPMailTableViewCell : UITableViewCell

- (void)setMessage:(MCOIMAPMessage *)message;

@end
