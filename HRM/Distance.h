//
//  Distance.h
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DataWithSubtitleLabel.h"

@interface Distance : DataWithSubtitleLabel
{
    CLLocationDistance totalDistance;
    
    NSMutableArray *registeredLocations;
}

- (void)calculateDistanceSinceStart:(id)oldDistance withNewDistance:(id)newDistance;

- (void)calculateCurrentDistanceWith:(CLLocation *)location;
- (void)resetRegisteredLocations;
- (void)registerLocation:(CLLocation *)location;

@end
