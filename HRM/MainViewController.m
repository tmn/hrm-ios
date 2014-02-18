//
//  MainViewController.m
//  HRM
//
//  Created by Tri M. Nguyen on 24/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@implementation MainViewController


- (void)loadView
{
    [super loadView];
    runningActive = NO;
    
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    map.delegate = self;
    
    UIView *mapOpacityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [mapOpacityView setBackgroundColor:[UIColor blackColor]];
    mapOpacityView.alpha = 0.6;
    
    AlphaGradientView *mapGradientView = [[AlphaGradientView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    [mapGradientView setColor:[UIColor colorWithRed:13.0/255.0 green:13.0/255.0 blue:22.0/255.0 alpha:1]];

    [self.view addSubview:mapGradientView];
    [self.view sendSubviewToBack:mapGradientView];

    [self.view addSubview:mapOpacityView];
    [self.view sendSubviewToBack:mapOpacityView];
    
    [self.view addSubview:map];
    [self.view sendSubviewToBack:map];
    
    
    /* Map region init
     -------------------------------------------------------------------------- */
    MKCoordinateRegion region;
    region.center.latitude      = 63.4305;
    region.center.longitude     = 10.395;
    region.span.latitudeDelta   = 0.01;
    region.span.longitudeDelta  = 0.01;
    
    [map setRegion:region animated:YES];
    
    
    
    if ([map respondsToSelector:@selector(setShowsPointsOfInterest:)])
    {
        // Turn off POIs on iOS7 (is there an iOS6 alternative?)
        map.showsPointsOfInterest = NO;
    }
    map.scrollEnabled = NO;
    map.zoomEnabled = NO;
    map.showsUserLocation = YES;
    
    if ([CLLocationManager locationServicesEnabled]) {
        [map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }

    [self.view setBackgroundColor:[UIColor colorWithRed:13.0/255.0 green:13.0/255.0 blue:22.0/255.0 alpha:1]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBpm) name:@"UpdateHRMData" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Stopwatch
     -------------------------------------------------------------------------- */
    stopwatch   = [[Stopwatch alloc] initWithFrame:CGRectMake(0, 135, 320, 85) ];
    
    calories    = [[Calories alloc] initWithFrame:CGRectMake(15, 230, 320, 60)
                                      displayText:@"0"
                                     displayTitle:@"calories burned"
                                        alignment:NSTextAlignmentLeft];
    speed       = [[Speed alloc] initWithFrame:CGRectMake(0, 230, 320, 60)
                                   displayText:@"0 km/h"
                                  displayTitle:@"speed"
                                     alignment:NSTextAlignmentRight];
    
    
    
    pace        = [[Pace alloc] initWithFrame:CGRectMake(15, 290, 320, 60)
                                  displayText:@"0.0 min/km"
                                 displayTitle:@"avg. pace"
                                    alignment:NSTextAlignmentLeft];
    currentPace = [[CurrentPace alloc] initWithFrame:CGRectMake(0, 290, 320, 60)
                                         displayText:@"0.0 min/km"
                                        displayTitle:@"current pace"
                                           alignment:NSTextAlignmentRight];
    
    elevation   = [[Elevation alloc] initWithFrame:CGRectMake(15, 350, 320, 60)
                                       displayText:@"0 m"
                                      displayTitle:@"elevation"
                                         alignment:NSTextAlignmentLeft];
    distance    = [[Distance alloc] initWithFrame:CGRectMake(0, 350, 320, 60)
                                      displayText:@"0 km"
                                     displayTitle:@"total distance"
                                        alignment:NSTextAlignmentRight];
    
    hrmax       = [[HRMax alloc] initWithFrame:CGRectMake(15, 112, 305, 30)];
    
    
    /* Location manager
    -------------------------------------------------------------------------- */
    locationManager                     = [[CLLocationManager alloc] init];
    locationManager.delegate            = self;
    locationManager.desiredAccuracy     = kCLLocationAccuracyBestForNavigation;
    locationManager.distanceFilter      = 1;
    
    [locationManager startUpdatingLocation];
    
    
    /* BPM informations
     -------------------------------------------------------------------------- */
    UIFont *bpmViewFont         = [UIFont fontWithName:@"HelveticaNeue-Light" size:110];
    NSString *bpmViewText       = @"000";
    CGSize bpmViewLabelSize     = [Common setSizeWithAttributeOn:bpmViewText with:bpmViewFont];
    
    bpmView = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, bpmViewLabelSize.width, bpmViewLabelSize.height)];
    bpmView.text = @"0";
    bpmView.font = bpmViewFont;
    bpmView.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    bpmView.textColor = [UIColor whiteColor];
    bpmView.textAlignment = NSTextAlignmentLeft;
    bpmView.backgroundColor = [UIColor clearColor];
    
    
    UIFont *bpmFooterFont       = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    NSString *bpmFooterText     = @"BPM";
    CGSize footerLabelSize      = [Common setSizeWithAttributeOn:bpmFooterText with:bpmFooterFont];
    
    bpmFooter = [[UILabel alloc] initWithFrame:CGRectMake(80, 85, footerLabelSize.width, footerLabelSize.height)];
    bpmFooter.text = bpmFooterText;
    bpmFooter.font = bpmFooterFont;
    bpmFooter.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    bpmFooter.textColor = [UIColor colorWithRed:9.0/255.0 green:113.0/255.0 blue:178.0/255.0 alpha:1];
    bpmFooter.textAlignment = NSTextAlignmentLeft;
    bpmFooter.backgroundColor = [UIColor clearColor];
    
    
    
    /* Start/stop button
     -------------------------------------------------------------------------- */
    startStopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    float btn_height = 60.0;
    float btn_width = 320.0;
    
    [startStopButton setFrame:CGRectMake(0, self.view.frame.size.height - btn_height-60, btn_width, btn_height)];
    [startStopButton setTitle:@"Start run" forState:UIControlStateNormal];
    [startStopButton addTarget:self action:@selector(startStopButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    startStopButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:72.0/255.0 alpha:1];
    [startStopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:startStopButton];
    [self.view addSubview:bpmView];
    [self.view addSubview:bpmFooter];
    
    [self.view addSubview:stopwatch];
    [self.view addSubview:calories];
    [self.view addSubview:speed];
    [self.view addSubview:pace];
    [self.view addSubview:currentPace];
    [self.view addSubview:elevation];
    [self.view addSubview:distance];
    [self.view addSubview:hrmax];
    
}

- (void)openMainMenuView
{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (UIImage *)screenyWithView:(MKMapView *)mapView
{
    UIGraphicsBeginImageContext(mapView.frame.size);
    [mapView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    NSLog(@"IMAGE CAPTURE");
    
    return viewImage;
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    
    if (fullyRendered)
    {
//        [self updateBackgroundWithImage:[self screenyWithView:mapView]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"test location");
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        
        [self updateInformationWithLocation:location];
    }
}

- (void)updateInformationWithLocation:(CLLocation *)location
{
    if (runningActive)
    {
        if (location != nil)
        {
            [elevation updateDisplayText:[NSString stringWithFormat:@"%.02f m", locationManager.location.altitude]];
            [distance calculateCurrentDistanceWith:location];
            [currentPace calculcateCurrentPace:[location speed]];
            [speed updateDisplayText:[NSString stringWithFormat:@"%.1f km/h", [location speed]*3600/1000]];
        }
        
        AppDelegate *appDelegate    = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [hrmax registerHeartRate:appDelegate.heartRate];
        
        [pace calculatePaceFromDistance:[distance totalDistance] time:[stopwatch getCurrentTimeInterval ]];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
}


- (IBAction) startStopButtonPressed:(id)sender
{
    [stopwatch startStopTimer];
    
    if (runningActive)
    {
        runningActive = NO;
    }
    else
    {
        runningActive = YES;
    }
}

- (void)reloadBpm
{
    AppDelegate *appDelegate    = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    bpmView.text                = [NSString stringWithFormat:@"%i", appDelegate.heartRate];
    
    UIFont *bpmFooterFont       = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    NSString *bpmFooterText     = @"BPM";
    CGSize footerLabelSize      = [Common setSizeWithAttributeOn:bpmFooterText with:bpmFooterFont];
    
    switch (bpmView.text.length) {
        case 1:
            bpmFooter.frame = CGRectMake(80, 85, footerLabelSize.width, footerLabelSize.height);
            break;
        case 2:
            bpmFooter.frame = CGRectMake(140, 85, footerLabelSize.width, footerLabelSize.height);
            break;
        case 3:
            bpmFooter.frame = CGRectMake(200, 85, footerLabelSize.width, footerLabelSize.height);
            break;
    }
    
    [self updateInformationWithLocation:nil];
}

- (void)dealloc
{
    map.delegate = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
