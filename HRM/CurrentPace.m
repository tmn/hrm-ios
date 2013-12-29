//
//  CurrentPace.m
//  HRM
//
//  Created by Tri M. Nguyen on 29/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "CurrentPace.h"

@implementation CurrentPace

- (void)calculcateCurrentPace:(CLLocationSpeed)speed
{
    if (speed > 0)
    {
        [self updateDisplayText:[NSString stringWithFormat:@"%.02f min/km", (1000/((speed*3600/1000)/60*1000))]];
    }
    else
    {
        [self updateDisplayText:@"0 min/km"];
    }
}

@end
