//
//  DataWithSubtitleLabel.h
//  HRM
//
//  Created by Tri M. Nguyen on 28/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface DataWithSubtitleLabel : UIView

@property (nonatomic, strong) NSString *dataDisplayText;
@property (nonatomic, strong) NSString *titleTextText;

@property (nonatomic, strong) UILabel *dataDisplay;
@property (nonatomic, strong) UILabel *titleText;

@property (nonatomic, strong) UIFont *dataDisplayFont;
@property (nonatomic, strong) UIFont *titleTextFont;
@property (nonatomic) NSInteger labelAlignment;

- (void)updateDisplayText:(NSString *)text;

- (void)drawLabels;
- (NSInteger)getLabelWidth;
- (id)initWithFrame:(CGRect)frame displayText:(NSString *)text displayTitle:(NSString *)title alignment:(NSInteger)alignment;

@end
