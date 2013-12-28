//
//  MainViewController.h
//  HRM
//
//  Created by Tri M. Nguyen on 24/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PebbleKit/PebbleKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
//#import <CoreLocation/CoreLocation.h>

#import "Stopwatch.h"
#import "Calories.h"
#import "Distance.h"
#import "Pace.h"
#import "HRMax.h"
#import "Elevation.h"
#import "Speed.h"

#import "Common.h"
#import "AlphaGradientView.h"

#import "UIViewController+MMDrawerController.h"


@interface MainViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    UILabel *bpmView;
    UILabel *bpmFooter;
    
    IBOutlet UIButton *startStopButton;
    
    Stopwatch *stopwatch;
    Calories *calories;
    Distance *distance;
    Pace *pace;
    HRMax *hrmax;
    Elevation *elevation;
    Speed *speed;
    
    MKMapView *map;
    
    UIImageView *backgroundImage;
    
    CLLocationManager* locationManager;
}


- (IBAction) startStopButtonPressed:(id)sender;

@end
