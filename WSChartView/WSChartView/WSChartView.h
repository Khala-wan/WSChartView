//
//  WSChartView.h
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSData.h"

@class WSChartView;


@protocol WSDataSource <NSObject>

@required

- (NSArray *)WSChartView_xLabelArrayForView:(WSChartView *)chartView;

- (NSArray *)WSChartView_yValueArrayForView:(WSChartView *)chartView;

@optional

- (NSArray *)WSChartView_ColorArrayForView:(WSChartView *)chartView;

- (NSArray *)WSChartView_xImageArrayForView:(WSChartView *)chartView;

- (CGRange)WSChartViewChooseRangeInLineChartView:(WSChartView *)chartView;

- (CGRange)WSChartViewMarkRangeInLineChartView:(WSChartView *)chartView;

- (BOOL)WSChartViewShowHorizontalLineAtIndex:(NSInteger)index;

- (BOOL)WSChartViewShowMaxandMinPointAtIndex:(NSInteger)index;

@end

@interface WSChartView : UIView

@property (nonatomic,assign) BOOL showRange;
@property (nonatomic,assign) WSChartViewStyle style;

- (instancetype)initWithFrame:(CGRect)frame WithChartViewStyle:(WSChartViewStyle)Style WithDataSource:(id<WSDataSource>)source;

- (void)showInView:(UIView *)view;

- (void)strokeChart;

@end
