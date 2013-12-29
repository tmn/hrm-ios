//
//  CurrentPace.h
//  HRM
//
//  Created by Tri M. Nguyen on 29/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "DataWithSubtitleLabel.h"

@interface CurrentPace : DataWithSubtitleLabel

- (void)calculcateCurrentPace:(CLLocationSpeed)speed;
@end
