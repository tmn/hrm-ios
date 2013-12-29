//
//  Pace.m
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "Pace.h"

@implementation Pace

- (void)calculatePaceFromDistance:(CLLocationDistance)totalDistance time:(NSTimeInterval)timeInterval
{
    NSLog(@"Total Distance: %f", totalDistance);
    NSLog(@"Time interval: %f", timeInterval);
    
    if (totalDistance > 0 && timeInterval > 0)
    {
        float pace = (timeInterval/60) / (totalDistance/1000);
       
        [self updateDisplayText:[NSString stringWithFormat:@"%i.%i min/km", (int)pace, (int)((fmod(pace, 1.0)/60*100)*100)]];
    }
    else
    {
        [self updateDisplayText:[NSString stringWithFormat:@"0.0 min/km"]];
    }
}
@end
