//
//  WSTableViewCell.m
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSTableViewCell.h"
#import "WSChartView.h"
#import "WSData.h"

@interface WSTableViewCell ()<WSDataSource>

@property (nonatomic,strong) WSChartView * chartView;
@property (nonatomic,assign) NSIndexPath * path;

@end

@implementation WSTableViewCell

- (void)setUpSubviews:(WSChartViewStyle)chartViewStyle AndIndexPath:(NSIndexPath*)indexPath{
        _path = indexPath;
    if (_chartView) {
        [_chartView removeFromSuperview];
        _chartView = nil;
    }
    
    _chartView = [[WSChartView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) WithChartViewStyle:chartViewStyle WithDataSource:self];
    self.backgroundColor = [UIColor colorWithRed:55/255 green:57/255 blue:58/255 alpha:0.4];
    [_chartView showInView:self.contentView];

}



- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"V-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

- (NSArray *)getImageNameArray:(int)num{

    NSMutableArray *xImageNames = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"WSImage--%d.png",i];
        [xImageNames addObject:str];
    }
    return xImageNames;

}

#pragma mark - @required

//横坐标标题数组
- (NSArray *)WSChartView_xLabelArrayForView:(WSChartView *)chart
{
    
    if (_path.section==0) {
        switch (_path.row) {
            case 0:
                return nil;
            case 1:
                return nil;
            case 2:
                return [self getXTitles:9];
            case 3:
                return [self getXTitles:10];
            default:
                break;
        }
    }else{
        switch (_path.row) {
            case 0:
                return [self getXTitles:9];
            case 1:
                return [self getXTitles:12];
            default:
                break;
        }
    }
    return [self getXTitles:20];
}
//数值多重数组
- (NSArray *)WSChartView_yValueArrayForView:(WSChartView *)chart
{
    NSArray *ary = @[@"12",@"34",@"15",@"25",@"8",@"47"];
    NSArray *ary1 = @[@"32",@"47",@"12",@"36",@"72",@"17",@"33",@"9"];
    NSArray *ary2 = @[@"56",@"36",@"74",@"13",@"56",@"42",@"17",@"8",@"27"];
    NSArray *ary3 = @[@"32",@"47",@"12",@"36",@"72",@"3",@"12",@"25",@"55",@"52"];
    NSArray *ary4 = @[@"13",@"55",@"25",@"70",@"30",@"62",@"32",@"36",@"47",@"31",@"33"];
    NSArray * array = [NSArray array];
    if (_path.section==0) {
        switch (_path.row) {
            case 0:
                array = @[ary];
                return array;
            case 1:
                return @[ary3];
            case 2:
                return @[ary1,ary2];
            default:
                return @[ary1,ary2,ary4];
        }
    }else{
        if (_path.row) {
            return @[ary1,ary3];
        }else{
            return @[ary2];
        }
    }
}

#pragma mark - @optional

- (NSArray *)WSChartView_xImageArrayForView:(WSChartView *)chartView{
    
    if (_path.section== 0) {
        switch (_path.row) {
            case 0:
                return [self getImageNameArray:6];
            case 1:
                return [self getImageNameArray:8];
            case 2:
                return nil;
            case 3:
                return nil;
            default:
                break;
        }
    }else{
        switch (_path.row) {
            case 0:
                return nil;
            case 1:
                return nil;
            default:
                break;
        }
    }
    return nil;
    
}

//颜色数组
- (NSArray *)WSChartView_ColorArrayForView:(WSChartView *)chart
{
    UIColor * white = [UIColor whiteColor];
    UIColor * green = [UIColor greenColor];
    UIColor * yellow = [UIColor yellowColor];
    return @[white,green,yellow];
}
//显示数值范围
- (CGRange)WSChartViewChooseRangeInLineChartView:(WSChartView *)chart
{
    if (_path.section==0 && (_path.row==0|_path.row==1)) {
        return CGRangeMake(100, 0);
    }
    if (_path.section==1 && _path.row==0) {
        return CGRangeMake(100, 0);
    }
    if (_path.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)WSChartViewMarkRangeInLineChartView:(WSChartView *)chart
{
    if (_path.row==2) {
        return CGRangeMake(20, 60);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)WSChartViewShowHorizontalLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)WSChartViewShowMaxandMinPointAtIndex:(NSInteger)index
{
    return _path.row==2;
}

@end
