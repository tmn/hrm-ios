//
//  Distance.m
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "Distance.h"

@implementation Distance

- (void)calculateDistanceSinceStart:(id)oldDistance withNewDistance:(id)newDistance
{
    
}

- (void)calculateCurrentDistanceWith:(CLLocation *)location
{
    if ([registeredLocations lastObject] != nil)
    {
        _totalDistance += [location distanceFromLocation:[registeredLocations lastObject]];
    }
    
    
    [self registerLocation:location];
    [self updateDisplayText:[NSString stringWithFormat:@"%.02f m", _totalDistance/1000]];
}

- (void)registerLocation:(CLLocation *)location
{
    if (registeredLocations == nil)
    {
        registeredLocations = [NSMutableArray array];
    }
    
    [registeredLocations addObject:location];
}

- (void)resetRegisteredLocations
{
    registeredLocations = nil;
}
@end
