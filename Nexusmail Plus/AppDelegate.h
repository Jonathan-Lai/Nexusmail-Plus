//
//  AppDelegate.h
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sharedAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*!
 Show login view controller with an alert
 */
- (void)handleInvalidUserCredentials;

/*!
 Logs user out. Replaces root view controller with the login view controller
 */
- (void)openLogin;

/*!
 Replaces root view controller with the mail tableView controller
 */
- (void)openMailWithUserID:(NSString *)userID password:(NSString *)password;

/*!
 UserID of the current user
 */
- (NSString *)currentSessionUserID;

/*!
 Password of the current user
 */
- (NSString *)currentSessionPassword;

@end
