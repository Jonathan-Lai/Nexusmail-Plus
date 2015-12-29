//
//  NPMailTableViewController.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPMailTableViewController.h"
#import "NPMailTableViewDatasource.h"
#import "SWRevealViewController.h"

static NSString *const inboxFolderName = @"INBOX";
static NSString *const sentFolderName = @"INBOX.Sent";
static NSString *const spamFolderName = @"INBOX.SPAM";

static NSString *const inboxTitle = @"Inbox";
static NSString *const sentTitle = @"Sent";
static NSString *const spamTitle = @"Spam";

@interface NPMailTableViewController()

@property (nonatomic, strong) NPMailTableViewDatasource *datasource;
@property (nonatomic, strong) UIBarButtonItem *revealButtonItem;

@end

@implementation NPMailTableViewController

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.title = inboxTitle;    // default folder is inbox
    }
    return self;
}

- (void)showInbox {
    self.title = inboxTitle;
    self.datasource.folder = inboxFolderName;
    [self.datasource refresh];
}

- (void)showSent {
    self.title = sentTitle;
    self.datasource.folder = sentFolderName;
    [self.datasource refresh];
}

- (void)showSpam {
    self.title = spamTitle;
    self.datasource.folder = spamFolderName;
    [self.datasource refresh];
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.datasource refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.revealButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = self.revealButtonItem;
    
    self.datasource = [[NPMailTableViewDatasource alloc] init];
    self.datasource.tableViewController = self;
    self.datasource.folder = inboxFolderName;  // default folder should be the inbox
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
