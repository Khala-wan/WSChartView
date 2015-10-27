//
//  WSBar.m
//  WSChartView
//
//  Created by 万圣 on 15/10/18.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSBar.h"

@implementation WSBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chartBar = [CAShapeLayer layer];
        _chartBar.lineCap = kCALineCapSquare;
        _chartBar.fillColor = [[UIColor whiteColor] CGColor];
        _chartBar.lineWidth = self.frame.size.width;
        _chartBar.strokeEnd = 0.0;
        self.clipsToBounds = YES;
        [self.layer addSublayer:_chartBar];
        self.layer.cornerRadius = 2.0;
    }
    return self;
}


- (void)setPp:(CGFloat)pp{

    if (pp==0)
        return;
    
    _pp = pp;
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height+30)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - pp) * self.frame.size.height+15)];
    
    [progressline setLineWidth:1.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _chartBar.path = progressline.CGPath;
    
    if (_barColor) {
        _chartBar.strokeColor = [_barColor CGColor];
    }else{
        _chartBar.strokeColor = [[UIColor whiteColor] CGColor];
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartBar addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartBar.strokeEnd = 2.0;

}

@end
