//
//  HRMax.m
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "HRMax.h"

@implementation HRMax

- (void)registerHeartRate:(NSInteger)hr
{
    if (maxHeartRate < hr)
    {
        maxHeartRate = hr;
        [self updateDisplayText:[NSString stringWithFormat:@"%i", maxHeartRate]];
    }
}
@end
