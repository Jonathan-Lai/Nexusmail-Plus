//
//  AppDelegate.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "AppDelegate.h"
#import "NPMailTableViewController.h"
#import "NPLoginViewController.h"
#import "NPMailBoxSelectionController.h"
#import "KeychainWrapper.h"
#import "SWRevealViewController.h"
#import "UIViewController+NPHelper.h"

@interface AppDelegate ()

@property (strong, nonatomic) NPMailTableViewController *mailTableViewController;
@property (strong, nonatomic) NPLoginViewController *loginViewController;
@property (strong, nonatomic) NPMailBoxSelectionController *mailBoxSelectionController;
@property (strong, nonatomic) SWRevealViewController *revealViewController;
@property (strong, nonatomic) KeychainWrapper *keychainItem;

@end

@implementation AppDelegate

- (void)handleInvalidUserCredentials {
    [self openLogin];
    [self.loginViewController showErrorMessage:@"Wrong user ID or password"];
}

- (void)openLogin {
    [self.keychainItem resetKeychainItem];
    self.window.rootViewController = self.loginViewController;
}

- (void)openMailWithUserID:(NSString *)userID password:(NSString *)password {
    [self.keychainItem mySetObject:password forKey:(__bridge NSString *)kSecValueData];
    [self.keychainItem mySetObject:userID forKey:(__bridge NSString *)kSecAttrAccount];
    
    self.window.rootViewController = self.revealViewController;
}

- (NSString *)currentSessionUserID {
    return [self.keychainItem myObjectForKey:(__bridge NSString *)kSecAttrAccount];
}

- (NSString *)currentSessionPassword {
    return [self.keychainItem myObjectForKey:(__bridge NSString *)kSecValueData];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.keychainItem = [[KeychainWrapper alloc] init];
    
    self.loginViewController = [[NPLoginViewController alloc] init];
    
    // Set up the reveal view controller
    self.mailTableViewController = [[NPMailTableViewController alloc] init];
    self.mailBoxSelectionController = [[NPMailBoxSelectionController alloc] init];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mailTableViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mailBoxSelectionController];
    self.revealViewController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    self.mailTableViewController.revealViewController = self.revealViewController;
    self.mailBoxSelectionController.revealViewController = self.revealViewController;
    self.mailBoxSelectionController.mailTableViewController = self.mailTableViewController;
    
    // If there is a userID saved, open up the mail tableView, else open the login screen
    if (self.currentSessionUserID.length) {
        self.window.rootViewController = self.revealViewController;
    } else {
        self.window.rootViewController = self.loginViewController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
