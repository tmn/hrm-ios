//
//  SettingsViewController.h
//  HRM
//
//  Created by Tri M. Nguyen on 25/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PairPickViewController.h"

#import "AppDelegate.h"


@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    PairPickViewController *pairDeviceView;
    
    IBOutlet UIButton* pairButton;
    
    UITableView *_tableView;
    
    UIScrollView *mainScrollView;
    
    NSMutableArray *menuSections;
    NSMutableArray *preferencesSection;
    NSMutableArray *accountSection;
}

@property (nonatomic, retain) PairPickViewController *pairDeviceView;


- (IBAction) pairButtonPressed:(id)sender;
@end
