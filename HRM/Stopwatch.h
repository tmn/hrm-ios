//
//  Stopwatch.h
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface Stopwatch : UIView
{
    UILabel *timerDisplay;
    UILabel *titleText;
    
    NSTimer *stopTimer;
    NSDate *startDate;
    NSDate *pauseDate;
    
    BOOL running;
}

@property (nonatomic) NSTimeInterval timeInterval;

- (void)updateTimer;
- (void)startStopTimer;
- (void)resetStopTimer;
- (NSTimeInterval)getCurrentTimeInterval;

@end
