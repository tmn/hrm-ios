//
//  SettingsViewController.m
//  HRM
//
//  Created by Tri M. Nguyen on 25/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController
@synthesize pairDeviceView;

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:13.0/255.0 green:13.0/255.0 blue:22.0/255.0 alpha:1]];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.showsVerticalScrollIndicator=YES;
    mainScrollView.scrollEnabled = YES;
    mainScrollView.userInteractionEnabled = YES;
    mainScrollView.contentSize = CGSizeMake(320, pairButton.frame.size.height);
//    mainScrollView = [[UIScrollView alloc] init];

    
    
    
    
    
    /* Create settings views
     -------------------------------------------------------------------------- */
    pairDeviceView = [[PairPickViewController alloc] init];
    
    
    /* Initiate settings table
     -------------------------------------------------------------------------- */
    menuSections        = [[NSMutableArray alloc] init];
    accountSection      = [[NSMutableArray alloc] init];
    preferencesSection  = [[NSMutableArray alloc] init];
    
    
    /* Building settings table
     -------------------------------------------------------------------------- */
    [menuSections addObject:accountSection];
    [menuSections addObject:preferencesSection];
    
    [preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];[preferencesSection addObject:pairDeviceView];
    
    /* Pairing shit
     -------------------------------------------------------------------------- */
    pairButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    float btn_height = 60.0;
    float btn_width = 320.0;
    
    
    [pairButton setFrame:CGRectMake(0, self.view.frame.size.height - btn_height-60, btn_width, btn_height)];
    [pairButton setTitle:@"Pair device" forState:UIControlStateNormal];
    [pairButton addTarget:self action:@selector(pairButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [pairButton setBackgroundColor:[UIColor colorWithRed:54.0/255.0 green:196.0/255.0 blue:51.0/255.0 alpha:1]];
    [pairButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    /* Tablefixing
     -------------------------------------------------------------------------- */
    NSInteger tableHeight = 0;
    for (NSMutableArray *a in menuSections)
    {
        tableHeight += [a count] * 44;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, tableHeight)];
    // _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    _tableView.scrollEnabled = NO;
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView reloadData];
    
    
    [mainScrollView setContentSize:CGSizeMake(320, tableHeight + 130)];
    /* Wrappup
     -------------------------------------------------------------------------- */
    [_tableView reloadData];
    [mainScrollView addSubview:_tableView];
    [mainScrollView addSubview:pairButton];
    
    [self.view addSubview:mainScrollView];
//    [self.view addSubview:_tableView];
//    [self.view addSubview:pairButton];
}


/* Actions
 -------------------------------------------------------------------------- */
- (IBAction)pairButtonPressed:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate startScan];
    [self.navigationController pushViewController:pairDeviceView animated:YES];
}



/* Tableview
 -------------------------------------------------------------------------- */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [menuSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *mArray = [menuSections objectAtIndex:section];
    return [mArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Account";
    }
    else if (section == 1)
    {
        return @"Preferences";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"SettingsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [[[menuSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0)
    {
//        [self.mm_drawerController setCenterViewController:[[menuSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
