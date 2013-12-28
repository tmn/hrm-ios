//
//  Common.m
//  HRM
//
//  Created by Tri M. Nguyen on 27/12/13.
//  Copyright (c) 2013 Tri M. Nguyen. All rights reserved.
//

#import "Common.h"

@implementation Common


+ (CGSize)setSizeWithAttributeOn:(NSString *)string with:(UIFont *)font
{
    CGSize size;
    
    if ([[[UIFont alloc] init] respondsToSelector:@selector(sizeWithAttributes:)])
    {
        size   = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    else
    {
        size   = [string sizeWithFont:font];
    }

    return size;
}
@end
