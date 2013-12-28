//
//  DataWithSubtitleLabel.m
//  HRM
//
//  Created by Tri M. Nguyen on 28/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "DataWithSubtitleLabel.h"

@implementation DataWithSubtitleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        _dataDisplayFont                = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        _titleTextFont                  = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        
        _dataDisplayText                = @"000";
        _titleTextText                  = @"lipsum";
        
        _labelAlignment                 = NSTextAlignmentLeft;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame displayText:(NSString *)text displayTitle:(NSString *)title alignment:(NSInteger)alignment
{
    self = [self initWithFrame:frame];
    
    if (self)
    {
        [self setLabelAlignment:alignment];
        [self setDataDisplayText:text];
        [self setTitleTextText:title];
        
        [self drawLabels];
    }
    
    return self;
}

- (NSInteger)getLabelWidth
{
    return (_labelAlignment == NSTextAlignmentLeft) ? 320 : 305;
}

- (void)drawLabels
{
    CGSize dataDisplayLabelSize     = [Common setSizeWithAttributeOn:_dataDisplayText with:_dataDisplayFont];
    CGSize titleTextLabelSize       = [Common setSizeWithAttributeOn:_titleTextText with:_titleTextFont];
    
    _dataDisplay = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [self getLabelWidth], dataDisplayLabelSize.height)];
    _dataDisplay.text               = _dataDisplayText;
    _dataDisplay.font               = _dataDisplayFont;
    _dataDisplay.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    _dataDisplay.textColor          = [UIColor whiteColor];
    _dataDisplay.textAlignment      = _labelAlignment;
    _dataDisplay.backgroundColor    = [UIColor clearColor];
    
    _titleText = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, [self getLabelWidth], titleTextLabelSize.height)];
    _titleText.text                 = _titleTextText;
    _titleText.font                 = _titleTextFont;
    _titleText.baselineAdjustment   = UIBaselineAdjustmentAlignBaselines;
    _titleText.textColor            = [UIColor colorWithWhite:1.0 alpha:.4];
    _titleText.textAlignment        = _labelAlignment;
    _titleText.backgroundColor      = [UIColor clearColor];
    
    [self addSubview:_dataDisplay];
    [self addSubview:_titleText];
}

- (void)updateDisplayText:(NSString *)text
{
    [self setDataDisplayText:text];
    [self.dataDisplay setText:[self dataDisplayText]];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
