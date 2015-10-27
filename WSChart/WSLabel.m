//
//  WSLabel.m
//  WSChartView
//
//  Created by 万圣 on 15/10/18.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSLabel.h"

@implementation WSLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        [self setMinimumScaleFactor:5.0f];
        [self setNumberOfLines:1];
        [self setFont:[UIFont boldSystemFontOfSize:9.0]];
        [self setTextColor: [UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
