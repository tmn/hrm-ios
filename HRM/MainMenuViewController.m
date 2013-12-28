//
//  MainMenuViewController.m
//  HRM
//
//  Created by Tri M. Nguyen on 25/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMainView:(id)view
{
    mainView = view;
    return self;
}

+ (NSInteger) PERSONAL_SECTION
{
    return 0;
}
+ (NSInteger) OTHER_SECTION
{
    return 1;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
//    settingsView = [[SettingsViewController alloc] initWithName:@"Settings"];

	
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView reloadData];
    
    menuSections = [[NSMutableArray alloc] init];
    
    personalSection = [[NSMutableArray alloc] init];
    otherSection = [[NSMutableArray alloc] init];
    
    [menuSections addObject:personalSection];
    [menuSections addObject:otherSection];
    
    
    [self.view addSubview:_tableView];
}

- (void)addViewToSection:(UINavigationController *)view atSection:(NSInteger)section
{
    if (section == [MainMenuViewController PERSONAL_SECTION])
    {
        [personalSection addObject:view];
    }
    else if (section == [MainMenuViewController OTHER_SECTION])
    {
        [otherSection addObject:view];
    }
    
    [_tableView reloadData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    
    cell.textLabel.text = [[[[menuSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] viewControllers][0] title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0)
    {
        [self.mm_drawerController setCenterViewController:[[menuSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
