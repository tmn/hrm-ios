//
//  Pace.h
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DataWithSubtitleLabel.h"

@interface Pace : DataWithSubtitleLabel

- (void)calculatePaceFromDistance:(CLLocationDistance) totalDistance time:(NSTimeInterval)timeInterval;

@end
