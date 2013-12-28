//
//  PairPickViewController.m
//  HRM
//
//  Created by Tri M. Nguyen on 24/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "PairPickViewController.h"
#import "AppDelegate.h"


@implementation PairPickViewController

#define mainNavController (((AppDelegate*)[[UIApplication sharedApplication] delegate]).myNav)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData) name:@"ReloadAppDelegateTable" object:nil];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = appDelegate;
    tableView.dataSource = appDelegate;
    [tableView reloadData];
    
    [self.view addSubview:tableView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate stopScan];
}



- (void)reloadTableViewData{
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
