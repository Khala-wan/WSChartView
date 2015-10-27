//
//  WSTableViewCell.h
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSData.h"

@class WSChartView;
@interface WSTableViewCell : UITableViewCell

- (void)setUpSubviews:(WSChartViewStyle)chartViewStyle AndIndexPath:(NSIndexPath *)path;

@end
