//
//  WSBarChartView.h
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "WSData.h"

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define WSXLabelHeight  10
#define WSYLabelHeight  10
#define WSYLabelwidth   30


@interface WSBarChartView : UIView


@property (nonatomic,assign) CGRange chooseRange;


@property (nonatomic,strong) NSArray * yLabels;
@property (nonatomic,strong) NSArray * xLabels;
@property (nonatomic,strong) NSArray * values;
@property (nonatomic,strong) NSArray * colors;

@property (nonatomic,assign) BOOL showRange;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;


-(void)strokeChart;
@end
