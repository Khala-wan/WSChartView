//
//  WSData.h
//  WSChartView
//
//  Created by 万圣 on 15/10/18.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>

struct Range{
    CGFloat max;
    CGFloat min;
};

typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange

CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0,0};


typedef enum{
    
    WSLineChartStyle,
    WSBarChartStyle
    
}WSChartViewStyle;

@interface WSData : NSObject

@end
