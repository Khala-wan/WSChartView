//
//  WSChartView.m
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSChartView.h"
#import "WSLineChartView.h"
#import "WSBarChartView.h"
#import "WSData.h"
@interface WSChartView ()

@property (nonatomic,strong) WSLineChartView * lineChartView;
@property (nonatomic,strong) WSBarChartView * barChartView;

@property (nonatomic,assign) id<WSDataSource> dataSource;
@end

@implementation WSChartView


- (instancetype) initWithFrame:(CGRect)frame WithChartViewStyle:(WSChartViewStyle)Style WithDataSource:(id<WSDataSource>)source{


    self.dataSource = source;
    self.style = Style;
    
    return [self initWithFrame:frame];

}

- (void)setUpChartView{
    
    
    switch (self.style) {
        case WSLineChartStyle:
            [self setUpLineChartView];
            break;
            
        case WSBarChartStyle:
            [self setUpBarChartView];
        default:
            break;
    }
   
       
}


- (void)showInView:(UIView *)view
{
    [self setUpChartView];
    [view addSubview:self];
}

-(void)strokeChart
{
    [self setUpChartView];
    
}

- (void)setUpLineChartView{
    if (!_lineChartView) {
        self.lineChartView = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:_lineChartView];
    }
    //选择标记范围
    if ([self.dataSource respondsToSelector:@selector(WSChartViewMarkRangeInLineChartView:)]) {
        [_lineChartView setMarkRange:[self.dataSource WSChartViewMarkRangeInLineChartView:self]];
    }
    //选择显示范围
    if ([self.dataSource respondsToSelector:@selector(WSChartViewChooseRangeInLineChartView:)]) {
        [_lineChartView setChooseRange:[self.dataSource WSChartViewChooseRangeInLineChartView:self]];
    }
    //显示颜色
    if ([self.dataSource respondsToSelector:@selector(WSChartView_ColorArrayForView:)]) {
        [_lineChartView setColors:[self.dataSource WSChartView_ColorArrayForView:self]];
    }
    //显示横线
    if ([self.dataSource respondsToSelector:@selector(WSChartViewShowHorizontalLineAtIndex:)]) {
        NSMutableArray *showHorizonArray = [[NSMutableArray alloc]init];
        for (int i=0; i<5; i++) {
            if ([self.dataSource WSChartViewShowHorizontalLineAtIndex:i]) {
                [showHorizonArray addObject:@"1"];
            }else{
                [showHorizonArray addObject:@"0"];
            }
        }
        [_lineChartView setShowHorizonLine:showHorizonArray];
        
    }
    //判断显示最大最小值
    if ([self.dataSource respondsToSelector:@selector(WSChartViewShowMaxandMinPointAtIndex:)]) {
        NSMutableArray *showMaxMinArray = [[NSMutableArray alloc]init];
        NSArray *y_values = [self.dataSource WSChartView_yValueArrayForView:self];
        if (y_values.count>0){
            for (int i=0; i<y_values.count; i++) {
                if ([self.dataSource WSChartViewShowMaxandMinPointAtIndex:i]) {
                    [showMaxMinArray addObject:@"1"];
                }else{
                    [showMaxMinArray addObject:@"0"];
                }
            }
            _lineChartView.ShowMaxMinArray = showMaxMinArray;
        }
    }
    
    [_lineChartView setYValues:[self.dataSource
                               WSChartView_yValueArrayForView:self]];
    if ([self.dataSource respondsToSelector:@selector(WSChartView_xImageArrayForView:)]) {
        NSArray * array = [self.dataSource WSChartView_xImageArrayForView:self];
        if (array != nil) {
            [_lineChartView setXImage:array];
        }
        else{
         _lineChartView.xLabel = [self.dataSource WSChartView_xLabelArrayForView:self];
        }
    }
    else{
         _lineChartView.xLabel = [self.dataSource WSChartView_xLabelArrayForView:self];
    }
    
    
    [_lineChartView strokeChart];
    
}



- (void)setUpBarChartView{
    if (!_barChartView) {
        self.barChartView = [[WSBarChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:_barChartView];
    }
    if ([self.dataSource respondsToSelector:@selector(WSChartViewChooseRangeInLineChartView:)]) {
           [_barChartView setChooseRange:[self.dataSource WSChartViewChooseRangeInLineChartView:self]];
            }
    if ([self.dataSource respondsToSelector:@selector(WSChartView_ColorArrayForView:)]) {
            [_barChartView setColors:[self.dataSource WSChartView_ColorArrayForView:self]];
        }
        _barChartView.values = [self.dataSource WSChartView_yValueArrayForView:self];
        [_barChartView setXLabels:[self.dataSource WSChartView_xLabelArrayForView:self]];
            
        [_barChartView strokeChart];

}


@end
