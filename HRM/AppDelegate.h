//
//  AppDelegate.h
//  HRM
//
//  Created by Tri M. Nguyen on 24/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <PebbleKit/PebbleKit.h>

#import "MainViewController.h"
#import "MainMenuViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

#import "MainViewController.h"
#import "SettingsViewController.h"
#import "HelpViewController.h"
#import "AboutViewController.h"
#import "DashboardViewController.h"

#import "UIViewController+MMDrawerController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource, PBPebbleCentralDelegate>
{
    UIWindow *window;
    CBCentralManager *manager;
    CBPeripheral *peripheral;
    
    NSMutableArray *heartRateMonitors;
    
    uint16_t heartRate;
    uuid_t myPebbleAppUUIDbytes;
    NSUUID *myPebbleAppUUID;
    
    BOOL autoConnect;
    
    MMDrawerController *viewController;
    UINavigationController *mainNavigationController;
    
    PBWatch *_targetWatch;
    
    PBWatch *connectedWatch;
}

@property (nonatomic, retain) MMDrawerController *viewController;
@property (nonatomic, retain) UINavigationController *mainNavigationController;
@property (nonatomic, retain) PBWatch *connectedWatch;


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *scanSheet;

@property (retain) NSMutableArray *heartRateMonitors;
@property (copy) NSString *connected;

@property (assign) uint16_t heartRate;
@property (retain) NSUUID *myPebbleAppUUID;




- (void) startScan;
- (void) stopScan;
- (void) updateWithHRMData:(NSData *)data;
@end
