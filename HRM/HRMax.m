//
//  HRMax.m
//  HRM
//
//  Created by Tri M. Nguyen on 26/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "HRMax.h"

@implementation HRMax

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIFont *maxHrTitleFont       = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        NSString *maxHrTitleText     = @"Max BPM:";
        CGSize maxHrTitleLabelSize   = [Common setSizeWithAttributeOn:maxHrTitleText with:maxHrTitleFont];
        
        maxHrTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxHrTitleLabelSize.width, maxHrTitleLabelSize.height)];
        maxHrTitle.text = maxHrTitleText;
        maxHrTitle.font = maxHrTitleFont;
        maxHrTitle.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        maxHrTitle.textColor = [UIColor colorWithWhite:1.0 alpha:.4];
        maxHrTitle.textAlignment = NSTextAlignmentLeft;
        maxHrTitle.backgroundColor = [UIColor clearColor];
        
        
        UIFont *maxHrFont       = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        NSString *maxHrText     = @"000";
        CGSize maxHrLabelSize   = [Common setSizeWithAttributeOn:maxHrText with:maxHrFont];
        
        maxHr = [[UILabel alloc] initWithFrame:CGRectMake(maxHrTitleLabelSize.width + 5, 0, maxHrLabelSize.width, maxHrLabelSize.height)];
        maxHr.text = @"0";
        maxHr.font = maxHrFont;
        maxHr.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        maxHr.textColor = [UIColor whiteColor];
        maxHr.textAlignment = NSTextAlignmentLeft;
        maxHr.backgroundColor = [UIColor clearColor];

        [self addSubview:maxHrTitle];
        [self addSubview:maxHr];
    }
    
    return self;
}

- (void)registerHeartRate:(NSInteger)hr
{
    if (maxHeartRate < hr)
    {
        maxHeartRate = hr;
        maxHr.text = [NSString stringWithFormat:@"%i", maxHeartRate];
        // [self updateDisplayText:];
    }
}
@end
