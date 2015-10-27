//
//  WSLineChartView.h
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSData.h"

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define WSXLabelHeight  10
#define WSYLabelHeight  10
#define WSYLabelwidth   30
#define WSXImageHeight  25
#define WSTagLabelwidth 80
#define AdjustmentMargin 10


@interface WSLineChartView : UIView

@property (nonatomic,assign) CGRange markRange;
@property (nonatomic,assign) CGRange chooseRange;


@property (nonatomic,strong) NSArray * yLabel;
@property (nonatomic,strong) NSArray * xLabel;
@property (nonatomic,strong) NSArray * xImage;
@property (nonatomic,strong) NSArray * yValues;
@property (nonatomic,strong) NSArray * colors;

@property (nonatomic,assign) BOOL showRange;

@property (nonatomic,assign) CGFloat xLabelWidth;
@property (nonatomic,assign) CGFloat xImageWidth;
@property (nonatomic,assign) CGFloat yValueMin;
@property (nonatomic,assign) CGFloat yValueMax;

@property (nonatomic,strong) NSMutableArray * ShowHorizonLine;
@property (nonatomic,strong) NSMutableArray * ShowMaxMinArray;

-(void)strokeChart;

@end
