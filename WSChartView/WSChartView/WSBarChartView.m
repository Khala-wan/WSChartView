//
//  WSBarChartView.m
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSBarChartView.h"
#import "WSLabel.h"
#import "WSBar.h"

@interface WSBarChartView ()

@property (nonatomic,strong) UIScrollView * scView;

@end

@implementation WSBarChartView

- (UIScrollView *)scView{

    if (!_scView) {
        _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(WSYLabelwidth, 0, self.bounds.size.width-WSYLabelwidth, self.bounds.size.height)];
    }
    return _scView;
}

- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self addSubview:self.scView];
    }
    return self;
}

-(void)setValues:(NSArray *)values
{
    _values = values;
    [self setYLabel:values];
}

-(void)setYLabel:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < 5) {
        max = 5;
    }
    if (self.showRange) {
        _yValueMin = (int)min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
         //NSLog(@"%d",_yValueMax);
        _yValueMin = _chooseRange.min;
    }
    
    float perAdd = (_yValueMax-_yValueMin) /4.0;
    CGFloat chartTableHeight = self.frame.size.height - 30;
    CGFloat perHeight = chartTableHeight /4.0;
    
    for (int i=0; i<5; i++) {
        WSLabel * label = [[WSLabel alloc] initWithFrame:CGRectMake(0.0,chartTableHeight-i*perHeight+5, WSYLabelwidth, WSXLabelHeight)];
        label.text = [NSString stringWithFormat:@"%.1f",perAdd * i+_yValueMin];
        [self addSubview:label];
    }
    
}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    NSInteger num;
    if (xLabels.count>=8) {
        num = 8;
    }else if (xLabels.count<=4){
        num = 4;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = _scView.frame.size.width/num;
    
    for (int i=0; i<xLabels.count; i++) {
        WSLabel * label = [[WSLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), self.frame.size.height - WSYLabelHeight, _xLabelWidth, WSXLabelHeight)];
        label.text = xLabels[i];
        [_scView addSubview:label];
    }
    
    float max = (([xLabels count]-1)*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (_scView.frame.size.width < max-10) {
        _scView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}
-(void)strokeChart
{
    
    CGFloat chartTableHeight = self.frame.size.height - 30;
    
    for (int i=0; i<_values.count; i++) {
        if (i==2)
            return;
        NSArray *ary = _values[i];
        for (int j=0; j<ary.count; j++) {
            NSString *valueString = ary[j];
            float value = [valueString floatValue];
            CGFloat percent = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            
            WSBar * bar = [[WSBar alloc] initWithFrame:CGRectMake((j+(_values.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, WSXLabelHeight, _xLabelWidth * (_values.count==1?0.8:0.45), chartTableHeight)];
            bar.barColor = [_colors objectAtIndex:i];
            bar.pp = percent;
            bar.barColor = [UIColor whiteColor];
            [_scView addSubview:bar];
            
        }
    }
}



@end
