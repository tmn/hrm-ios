//
//  DashboardViewController.m
//  HRM
//
//  Created by Tri M. Nguyen on 25/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

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
    [self.view setBackgroundColor:[UIColor colorWithRed:13.0/255.0 green:13.0/255.0 blue:22.0/255.0 alpha:1]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
