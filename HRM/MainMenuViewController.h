//
//  MainMenuViewController.h
//  HRM
//
//  Created by Tri M. Nguyen on 25/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"

@interface MainMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    
    UINavigationController *mainView;
    
    NSMutableArray *menuSections;
    NSMutableArray *personalSection;
    NSMutableArray *otherSection;
}

+ (NSInteger) PERSONAL_SECTION;
+ (NSInteger) OTHER_SECTION;

- (id)initWithMainView:(id)view;
//- (void)addView:(UINavigationController *)navview;
- (void)addViewToSection:(UINavigationController *)view atSection:(NSInteger)section;

@end
