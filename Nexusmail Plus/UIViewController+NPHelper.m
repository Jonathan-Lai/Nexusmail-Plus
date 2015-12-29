//
//  UIViewController+NPHelper.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-29.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "UIViewController+NPHelper.h"

@implementation UIViewController (NPHelper)

- (void)showErrorMessage:(NSString *)message {
    // Show alert that the user's ID or Password are invalid
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert                   ];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [errorAlertController dismissViewControllerAnimated:YES completion:nil];
                         }];
    [errorAlertController addAction: ok];
    [self presentViewController:errorAlertController animated:YES completion:nil];
}

@end
