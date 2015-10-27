//
//  WSLineChartView.m
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSLineChartView.h"

#import "WSLabel.h"

@implementation WSLineChartView

-(void)setYValues:(NSArray *)yValues{

    _yValues = yValues;
    [self setUpYLabels:_yValues];

}

- (void)setUpYLabels:(NSArray *)yVlaues{

    static NSInteger max = 0;
    static NSInteger min = 99999999;
    
    for (NSArray * array in yVlaues ) {
        for (NSString * valueString in array ) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
            if (max < 5) {
                max = 5;
            }
            if (_showRange) {
                _yValueMin = min;
            }
            else _yValueMin = 0;
            
            _yValueMax = (int)max;
            
            if (_chooseRange.max!=_chooseRange.min) {
                _yValueMax = _chooseRange.max;
                _yValueMin = _chooseRange.min;
            }
        }
    }
    
    float perAdd = (_yValueMax-_yValueMin) /4.0;
    CGFloat chartTableHeight = self.frame.size.height - 30;
    CGFloat perHeight = chartTableHeight / 4.0;

    
    for (int i=0; i<5; i++) {
        WSLabel * label = [[WSLabel alloc] initWithFrame:CGRectMake(0.0,chartTableHeight-i*perHeight+5, WSYLabelwidth, WSYLabelHeight)];
        label.text = [NSString stringWithFormat:@"%d",(int)(perAdd * i+_yValueMin)];
        [self addSubview:label];
    }
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(WSYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartTableHeight+WSXLabelHeight, self.frame.size.width-WSYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartTableHeight)];
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        [self addSubview:view];
    }
    
    //横向格子线
    for (int i=0; i<5; i++) {
        if ([_ShowHorizonLine[i] integerValue]>0) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(WSYLabelwidth,WSXLabelHeight+i*perHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,WSYLabelHeight+i*perHeight)];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
            //shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
    }

}

-(void)setXLabel:(NSArray *)xLabels
{
    _xLabel = xLabels;
    CGFloat num = 0;
    if (xLabels.count>=20) {
        num=20.0;
    }else if (xLabels.count<=1){
        num=1.0;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = (self.frame.size.width - WSYLabelwidth)/num;
    
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        WSLabel * label = [[WSLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth+WSYLabelwidth, self.frame.size.height - WSXLabelHeight, _xLabelWidth, WSXLabelHeight)];
        label.text = labelText;
        [self addSubview:label];
    }
    
    //画竖线
    for (int i=0; i<xLabels.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(WSYLabelwidth+i*_xLabelWidth,WSXLabelHeight)];
        [path addLineToPoint:CGPointMake(WSYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*WSXLabelHeight)];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
        //shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
    }
}

- (void)setXImage:(NSArray *)xImage{
   
    _xImage = xImage;
    CGFloat num = 0;
    if (xImage.count>=20) {
        num=20.0;
    }else if (xImage.count<=1){
        num=1.0;
    }else{
        num = xImage.count;
    }
    _xImageWidth = (self.frame.size.width - WSYLabelwidth)/num;
    
    for (int i=0; i<xImage.count; i++) {
        NSString *imageName = xImage[i];
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(i * _xImageWidth+WSYLabelwidth, self.frame.size.height - WSXImageHeight + AdjustmentMargin , _xImageWidth, WSXImageHeight)];
        image.image = [UIImage imageNamed:imageName];
        //image.backgroundColor = [UIColor greenColor];
        [self addSubview:image];
    }
    
    //画竖线
    for (int i=0; i<xImage.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(WSYLabelwidth+i*_xImageWidth,10)];
        [path addLineToPoint:CGPointMake(WSYLabelwidth+i*_xImageWidth,self.frame.size.height-2*10)];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
    }
}

-(void)strokeChart
{
    for (int i=0; i < _yValues.count; i++) {
        NSArray *ary = _yValues[i];
        if (ary.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [ary[0] floatValue];
        CGFloat min = [ary[0] floatValue];
        NSInteger max_i;
        NSInteger min_i;
        
        for (int j=0; j<ary.count; j++){
            CGFloat num = [ary[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor blackColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        if (_xImage.count != 0) {
            _xLabelWidth = _xImageWidth;
        }
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[ary objectAtIndex:0] floatValue];
        CGFloat xPosition = (WSYLabelwidth + _xLabelWidth/2.0);
        CGFloat chartTableHeight = self.frame.size.height - WSXLabelHeight*3;
        
        float percent = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        

        BOOL isShowMaxAndMinPoint = YES;
        if (self.ShowMaxMinArray) {
            if ([self.ShowMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        CGPoint targetPoint = CGPointMake(xPosition, chartTableHeight - percent * chartTableHeight+WSXLabelHeight);
        [self addPoint:targetPoint
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];
        
        
        [progressline moveToPoint:targetPoint];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in ary) {
            
            float percent =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint targetPoint = CGPointMake(xPosition+index*_xLabelWidth, chartTableHeight - percent * chartTableHeight+WSXLabelHeight);
                [progressline addLineToPoint:targetPoint];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.ShowMaxMinArray) {
                    if ([self.ShowMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:targetPoint];
                [self addPoint:targetPoint
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        }else{
            _chartLine.strokeColor = [UIColor yellowColor].CGColor;
        }
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = ary.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        _chartLine.strokeEnd = 1.0;
    }
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [[_colors objectAtIndex:index] CGColor]?[[_colors objectAtIndex:index] CGColor]:[UIColor whiteColor].CGColor;
    
    if (isHollow) {
        view.backgroundColor = [UIColor grayColor];
    }else{
        view.backgroundColor = [_colors objectAtIndex:index]?[_colors objectAtIndex:index]:[UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-WSTagLabelwidth/2.0, point.y-WSYLabelHeight*2, WSTagLabelwidth, WSXLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}



@end
