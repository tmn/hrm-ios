//
//  HRMax.h
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataWithSubtitleLabel.h"

@interface HRMax : UIView
{
    UILabel *maxHrTitle;
    UILabel *maxHr;
    
    NSInteger maxHeartRate;
}

- (void)registerHeartRate:(NSInteger)hr;

@end
