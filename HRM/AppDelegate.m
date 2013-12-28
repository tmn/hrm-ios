//
//  AppDelegate.m
//  HRM
//
//  Created by Tri M. Nguyen on 24/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;
@synthesize heartRateMonitors;
@synthesize connected;
@synthesize heartRate;
@synthesize connectedWatch;
@synthesize myPebbleAppUUID;
@synthesize mainNavigationController;
@synthesize viewController;

#define HRMSERVICEUUID @"180D"
#define HEARTRATEMEASUREMENTUUID @"2A37"
#define BODYSENSORLOCATIONUUID @"2A38"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *runView             = [[MainViewController alloc] init];
    DashboardViewController *dashboardView  = [[DashboardViewController alloc] init];
    SettingsViewController *settingsView    = [[SettingsViewController alloc] init];
    HelpViewController *helpView            = [[HelpViewController alloc] init];
    AboutViewController *aboutView          = [[AboutViewController alloc] init];
    
    [runView setTitle:@"Run"];
    [dashboardView setTitle:@"Dashboard"];
    [settingsView setTitle:@"Settings"];
    [helpView setTitle:@"Help"];
    [aboutView setTitle:@"About"];
    
    
    UINavigationController *navRun          = [[UINavigationController alloc] initWithRootViewController:runView];
    UINavigationController *navDashboard    = [[UINavigationController alloc] initWithRootViewController:dashboardView];
    UINavigationController *navSettings     = [[UINavigationController alloc] initWithRootViewController:settingsView];
    UINavigationController *navAbout        = [[UINavigationController alloc] initWithRootViewController:aboutView];
    
    MainMenuViewController *mainMenu        = [[MainMenuViewController alloc] initWithMainView:navRun];

    self.viewController                     = [[MMDrawerController alloc]
                                                initWithCenterViewController:navRun
                                                    leftDrawerViewController:mainMenu];
    
    [self.viewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
    [self.viewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView|MMCloseDrawerGestureModePanningNavigationBar|MMCloseDrawerGestureModeTapCenterView];
    
    [mainMenu addViewToSection:navRun atSection:[MainMenuViewController PERSONAL_SECTION]];
    [mainMenu addViewToSection:navDashboard atSection:[MainMenuViewController PERSONAL_SECTION]];
    [mainMenu addViewToSection:navSettings atSection:[MainMenuViewController OTHER_SECTION]];
    [mainMenu addViewToSection:navAbout atSection:[MainMenuViewController OTHER_SECTION]];
    
    /* Adjust mainNavigationController appearance
     -------------------------------------------------------------------------- */
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowOffset:CGSizeMake(-1, 0)];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],NSForegroundColorAttributeName,
//                                               shadow, NSShadowAttributeName,
                                               nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
//    UIColor *tintColor = [UIColor colorWithRed:37.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1];
    UIColor *tintColor = [UIColor colorWithRed:20.0/255.0 green:133.0/255.0 blue:204.0/255.0 alpha:1];
    if ([[[UINavigationController alloc] init].navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        [[UINavigationBar appearance] setBarTintColor:tintColor];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    else
    {
        [[UINavigationBar appearance] setTintColor:tintColor];
    }
    
    [navRun.navigationBar setTranslucent:NO];
    [navDashboard.navigationBar setTranslucent:NO];
    [navSettings.navigationBar setTranslucent:NO];
    [navAbout.navigationBar setTranslucent:NO];
    
    
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    
    /* Show burger menu toggle
     -------------------------------------------------------------------------- */
    MMDrawerBarButtonItem *showMainMenuButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(openMainMenuView)];
    runView.navigationItem.leftBarButtonItem        = showMainMenuButton;
    settingsView.navigationItem.leftBarButtonItem   = showMainMenuButton;
    dashboardView.navigationItem.leftBarButtonItem  = showMainMenuButton;
    aboutView.navigationItem.leftBarButtonItem      = showMainMenuButton;
    
    
    
    /* Initialize with the last connected watch:
     -------------------------------------------------------------------------- */
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    [self setTargetWatch:[[PBPebbleCentral defaultCentral] lastConnectedWatch]];
    
    
    /* Initialize heart rate monitor values
     -------------------------------------------------------------------------- */
    self.heartRate          = 0;
    self.heartRateMonitors  = [NSMutableArray array];
    
    
    autoConnect             = TRUE;
    manager                 = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    return YES;
}

- (void)openMainMenuView
{
    [self.viewController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)setTargetWatch:(PBWatch *)watch
{
    _targetWatch = watch;
    
    [watch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported)
     {
         if (isAppMessagesSupported)
         {
             self.myPebbleAppUUID = [[NSUUID alloc] initWithUUIDString:@"63615b1b-d965-4893-a496-a4f78329fc92"];
             [self.myPebbleAppUUID getUUIDBytes:myPebbleAppUUIDbytes];
             
             [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myPebbleAppUUIDbytes length:16]];
         }
         else
         {
             NSLog(@"Lol noobs");
         }
     }];
}


- (void) startScan
{
    NSArray *services = @[ [CBUUID UUIDWithString:HRMSERVICEUUID] ];
    
    [manager scanForPeripheralsWithServices:services options:nil];
    
    NSLog(@"Scan started");
}

- (void) stopScan
{
    [manager stopScan];
    
    NSLog(@"Scan stopped");
}


- (void) updateWithHRMData:(NSData *) data
{
    const uint8_t *reportData = [data bytes];
    uint16_t bpm = 0;
    
    __block NSString *message = @"";
    
    /*void (^showAlert)(void) = ^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
    };*/
    
    if ((reportData[0] & 0x01) == 0)
    {
        bpm = reportData[1];
    }
    else
    {
        bpm = CFSwapInt16LittleToHost(*(uint16_t *)(&reportData[1]));
    }
    
    uint16_t oldBpm = self.heartRate;
    self.heartRate = bpm;
    
    if (oldBpm == 0)
    {
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateHRMData" object:nil];
    
    
    NSDictionary *update = @{ @(0):[NSString stringWithFormat:@"%i", self.heartRate],
                              @(1):@"a string" };
    
    [_targetWatch appMessagesPushUpdate:update onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
        message = error ? [error localizedDescription] : @"Update sent!";
        // showAlert();
    }];
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)aPeripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSMutableArray *peripherals = [self mutableArrayValueForKey:@"heartRateMonitors"];
    
    if ( ![self.heartRateMonitors containsObject:aPeripheral])
    {
        [peripherals addObject:aPeripheral];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAppDelegateTable" object:nil];
    }
    
    if (autoConnect)
    {
        // [manager retrievePeripheralsWithIdentifiers:[NSArray arrayWithObject:aPeripheral.identifier]];
        [manager retrievePeripherals:[NSArray arrayWithObject:(id)aPeripheral.UUID]];
    }
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn)
    {
        if (autoConnect)
        {
            [self startScan];
        }
    }
    else
    {
        NSLog(@"I'm off!!");
    }
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    // NSLog(@"Retrieved peripherals: %lu - %@", (unsigned long)[peripherals count], peripherals);
    
    [self stopScan];
    
    if ([peripherals count] > 0)
    {
        peripheral = [peripherals objectAtIndex:0];
        [manager connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral
{
    [aPeripheral setDelegate:self];
    [aPeripheral discoverServices:nil];
    
    self.connected = @"Connected";
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error
{
    for (CBService *aService in aPeripheral.services)
    {
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:HRMSERVICEUUID]])
        {
            [aPeripheral discoverCharacteristics:nil forService:aService];
        }
    }
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if ([service.UUID isEqual:[CBUUID UUIDWithString:HRMSERVICEUUID]])
    {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:HEARTRATEMEASUREMENTUUID]])
            {
                [peripheral setNotifyValue:YES forCharacteristic:aChar];
            }
            
            /*if ([aChar.UUID isEqual:[CBUUID UUIDWithString:BODYSENSORLOCATIONUUID]])
            {
                [aPeripheral readValueForCharacteristic:aChar];
            }*/
        }
    }
}


- (void) peripheral:(CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:HEARTRATEMEASUREMENTUUID]])
    {
        if (characteristic.value || !error)
        {
            [self updateWithHRMData:characteristic.value];
        }
        
    }
}



/* Tableview
 -------------------------------------------------------------------------- */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Number of rows is the number of time zones in the region for the specified section.
    
    return [heartRateMonitors count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // The header for the section is the region name -- get this from the region at the section index.
    // Region *region = [regions objectAtIndex:section];
    // return [region name];
    return @"Devices";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Pick a device from the list";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"DeviceOverviewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    CBPeripheral *aPeripheral = [heartRateMonitors objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aPeripheral.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self stopScan];
    
    if (indexPath.row >= 0)
    {
        peripheral = [self.heartRateMonitors objectAtIndex:indexPath.row];
        [manager connectPeripheral:peripheral options:nil];
    }
    
}


/* Pebble
 -------------------------------------------------------------------------- */
- (void)pebbleCentral:(PBPebbleCentral*)central watchDidConnect:(PBWatch*)watch isNew:(BOOL)isNew {
    [self setTargetWatch:watch];
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidDisconnect:(PBWatch*)watch {
    NSLog(@"Pebble disconnected: %@", [watch name]);
    
    [[[UIAlertView alloc] initWithTitle:@"Disconnected!" message:[watch name] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    if (_targetWatch == watch || [watch isEqual:_targetWatch]) {
        [self setTargetWatch:nil];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
