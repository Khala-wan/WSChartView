//
//  WSRootTableViewController.m
//  WSChartView
//
//  Created by 万圣 on 15/10/17.
//  Copyright © 2015年 万圣. All rights reserved.
//

#import "WSRootTableViewController.h"
#import "WSTableViewCell.h"
#import "WSData.h"

@interface WSRootTableViewController ()<UITableViewDataSource>

@end

@implementation WSRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"WSChart";
    self.tableView.dataSource = self;
    CGPoint center = self.view.center;
    center.y += 10;
    self.tableView.center = center;
    [self.tableView registerClass:[WSTableViewCell class] forCellReuseIdentifier:@"WSCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section ? 2:4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"WSCell";
    
    WSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    WSChartViewStyle style = indexPath.section == 0?WSLineChartStyle :       WSBarChartStyle;
    [cell setUpSubviews:style AndIndexPath:indexPath];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 30);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [UIColor colorWithRed:55/255 green:57/255 blue:58/255 alpha:0.8];
    label.text = section ? @"柱状图":@"线型图";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}



@end
