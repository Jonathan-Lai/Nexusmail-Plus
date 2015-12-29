//
//  NPLoginViewController.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-28.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "AppDelegate.h"
#import "NPLoginViewController.h"
#import "NPStyling.h"
#import "UIViewController+NPHelper.h"

static const NSInteger kUWLogoWidth = 300;
static const NSInteger kUWLogoHeight = 120;
static const NSInteger kNexusPlusLogoWidth = 350;
static const NSInteger kNexusPlusLogoHeight = 100;
static const NSInteger kSmallMargin = 20;
static const NSInteger kLoginButtonWidth = 300;
static const NSInteger kLoginButtonHeight = 50;
static const NSInteger KTextFieldHeight = 43;
static const NSInteger kTextFieldMargin = 10;
static const NSInteger kTopMargin = 40;
static const NSInteger kBottomMargin = 250;

@interface NPLoginViewController() <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *UWLogoView;
@property (nonatomic, strong) UIImageView *nexusPlusLogoView;
@property (nonatomic, strong) UITextField *userIDTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation NPLoginViewController

- (id)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        _UWLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UniversityOfWaterloo_logo_horiz_rgb.png"]];
        _UWLogoView.translatesAutoresizingMaskIntoConstraints = NO;
        _UWLogoView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_UWLogoView];
        
        _nexusPlusLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NEXUS+logo.png"]];
        _nexusPlusLogoView.translatesAutoresizingMaskIntoConstraints = NO;
        _nexusPlusLogoView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_nexusPlusLogoView];
        
        _userIDTextField = [[UITextField alloc] init];
        _userIDTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _userIDTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _userIDTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userIDTextField.placeholder = @"Enter your UW User ID";
        _userIDTextField.font = [NPStyling mediumFont];
        _userIDTextField.delegate = self;
        [self.view addSubview:_userIDTextField];
        
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.placeholder = @"Enter your password";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.font = [NPStyling mediumFont];
        _passwordTextField.delegate = self;
        [self.view addSubview:_passwordTextField];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _loginButton.titleLabel.font = [NPStyling mediumFont];
        _loginButton.backgroundColor = [NPStyling blueColor];
        [_loginButton addTarget:self action:@selector(_login) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissKeyboard)];
        [self.view addGestureRecognizer:tapGestureRecognizer];
        
        [self _setContraints];
    }
    return self;
}

- (void)_setContraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_UWLogoView, _nexusPlusLogoView, _userIDTextField, _passwordTextField, _loginButton);
    NSDictionary *metrics = @{ @"kUWLogoWidth" : @(kUWLogoWidth),
                               @"kUWLogoHeight" : @(kUWLogoHeight),
                               @"kNexusPlusLogoWidth" : @(kNexusPlusLogoWidth),
                               @"kNexusPlusLogoHeight" : @(kNexusPlusLogoHeight),
                               @"kSmallMargin" :@(kSmallMargin),
                               @"kLoginButtonWidth" :@(kLoginButtonWidth),
                               @"kLoginButtonHeight" :@(kLoginButtonHeight),
                               @"KTextFieldHeight" : @(KTextFieldHeight),
                               @"kTextFieldMargin" : @(kTextFieldMargin),
                               @"kTopMargin" : @(kTopMargin),
                               @"kBottomMargin" : @(kBottomMargin) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(kTopMargin)-[_UWLogoView(kUWLogoHeight)][_nexusPlusLogoView(kNexusPlusLogoHeight)]-(>=0)-[_userIDTextField(KTextFieldHeight)]-(kTextFieldMargin)-[_passwordTextField(KTextFieldHeight)]-(kSmallMargin)-[_loginButton(kLoginButtonHeight)]-(kBottomMargin)-|" options:0 metrics:metrics views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_UWLogoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kUWLogoWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nexusPlusLogoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kNexusPlusLogoWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kLoginButtonWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kLoginButtonWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kLoginButtonWidth]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_UWLogoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nexusPlusLogoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

#pragma mark - Private

- (void)_dismissKeyboard {
    [self.userIDTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)_login {
    if (self.userIDTextField.text.length && self.passwordTextField.text.length) {
        [sharedAppDelegate openMailWithUserID:self.userIDTextField.text password:self.passwordTextField.text];
    } else {
        [self showErrorMessage:@"Type user ID and password"];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userIDTextField) {
        [self.userIDTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
        return NO;
    } else if (textField == self.passwordTextField) {
        [self.userIDTextField resignFirstResponder];
        [self _login];
    }
    return YES;
}

@end
