//
//  Stopwatch.m
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "Stopwatch.h"

@implementation Stopwatch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIFont *timerDisplayFont        = [UIFont fontWithName:@"HelveticaNeue-Light" size:36];
        UIFont *titleTextFont           = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        
        NSString *timerDisplayText      = @"00:00:00";
        NSString *titleTextText         = @"elapsed time";
        
        CGSize timerDisplayLabelSize    = [Common setSizeWithAttributeOn:timerDisplayText with:timerDisplayFont];
        CGSize titleTextLabelSize       = [Common setSizeWithAttributeOn:titleTextText with:titleTextFont];
        
        
        timerDisplay = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, timerDisplayLabelSize.height)];
        timerDisplay.text = timerDisplayText;
        timerDisplay.font = timerDisplayFont;
        timerDisplay.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        timerDisplay.textColor = [UIColor whiteColor];
        timerDisplay.textAlignment = NSTextAlignmentCenter;
        timerDisplay.backgroundColor = [UIColor clearColor];
        
        titleText = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 320, titleTextLabelSize.height)];
        titleText.text = titleTextText;
        titleText.font = titleTextFont;
        titleText.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        titleText.textColor = [UIColor colorWithWhite:1.0 alpha:.4];
        titleText.textAlignment = NSTextAlignmentCenter;
        titleText.backgroundColor = [UIColor clearColor];
        
        
        startDate           = [NSDate date];
        running             = FALSE;
        _timeInterval        = 0;
        
        [self addSubview:timerDisplay];
        [self addSubview:titleText];
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1.0 alpha:0.2].CGColor);
    CGContextFillRect(ctx, CGRectMake(15, 0, 310, 0.5f));
}


- (void)updateTimer
{
    NSDate *currentDate             = [NSDate date];
    NSTimeInterval timeIntervalTmp  = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate               = [NSDate dateWithTimeIntervalSince1970:_timeInterval + timeIntervalTmp];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString            = [dateFormatter stringFromDate:timerDate];
    timerDisplay.text               = timeString;
}

- (void)startStopTimer
{

    
    if (!running)
    {
        startDate = [NSDate date];

        running = TRUE;
        if (stopTimer == nil)
        {
            stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
            NSLog(@"Timer started");
        }
    }
    else
    {
        running = FALSE;
        
        [stopTimer invalidate];
        stopTimer = nil;
        
        [self pauseTimer];
    }
}

- (void)resetStopTimer
{
    [stopTimer invalidate];
    stopTimer = nil;
    
    startDate = [NSDate date];
    timerDisplay.text = @"00.00.00";
    running = FALSE;
}

- (void)pauseTimer
{
    _timeInterval += [[NSDate date] timeIntervalSinceDate:startDate];
    NSLog(@"Pause timer");
}

@end
