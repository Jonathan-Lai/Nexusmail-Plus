//
//  NPMailTableViewController.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPMailTableViewController.h"
#import "NPMailTableViewDatasource.h"

@interface NPMailTableViewController()

@property (nonatomic, strong) NPMailTableViewDatasource *datasource;

@end

@implementation NPMailTableViewController

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        // Nothing to do here
    }
    return self;
}

- (void)showErrorMessage:(NSString *)message {
    // Show alert that the user's ID or Password are invalid
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Login Error"
                                                                                  message: @"Wrong user ID or password"
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

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.datasource refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datasource = [[NPMailTableViewDatasource alloc] init];
    self.datasource.tableViewController = self;
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self.datasource;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(_refresh) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Private

- (void)_refresh {
    [self.refreshControl endRefreshing];
    [self.datasource refresh];
}

@end
