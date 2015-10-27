# WSChartView
framework for draw line or bar chart
Line and Bar charts. You can mark the range of values you want, and show the max or min values in linechartview.

## Introduction
  
 * WSChartView
 * WSLineChartView
 * WSBarChartView
 * WSData
 * WSBar
 * WSLabel
 
## Usage

### init

  - (instancetype)initWithFrame:(CGRect)frame WithChartViewStyle:(WSChartViewStyle)Style WithDataSource:(id<WSDataSource>)source;

## WSDataSource
####required

  - (NSArray *)WSChartView_xLabelArrayForView:(WSChartView *)chartView;

  - (NSArray *)WSChartView_yValueArrayForView:(WSChartView *)chartView;

####optional

    // the colors for lines and bars.
  - (NSArray *)WSChartView_ColorArrayForView:(WSChartView *)chartView;
    //CGRange CGRangeMake(CGFloat max, CGFloat min);
  - (CGRange)WSChartViewChooseRangeInLineChartView:(WSChartView *)chartView;
    //You can insert images instead labels
  - (NSArray *)WSChartView_xImageArrayForView:(WSChartView *)chartView;

####Additional options available for WSChartLineStyle

    //Mark the range of values with whiteColor if you need
    - (CGRange)WSChartViewMarkRangeInLineChartView:(WSChartView *)chartView;

    //You can choose horizonLine which you want to show
    - (BOOL)WSChartViewShowHorizontalLineAtIndex:(NSInteger)index;

    // Show the label on the max and min values with their colors.
    - (BOOL)WSChartViewShowMaxandMinPointAtIndex:(NSInteger)index;

#### Select from two styles for WSChartView:

WSLineChartStyle
WSBarChartStyle


#### WSChart, based on kevinzhow's [UUChart]


### Demo

   _chartView = [[WSChartView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) WithChartViewStyle:chartViewStyle WithDataSource:self];
   _chartView.backgroundColor = [UIColor colorWithRed:55/255 green:57/255 blue:58/255 alpha:0.4];
   [_chartView showInView:self.contentView];

//Horizontal Axis Label

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
	
//Creating multiple array values (note the datatype)

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
//array for images
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
        break;
        }
    }
    return nil;

}


//Array of colors

- (NSArray *)WSChartView_ColorArrayForView:(WSChartView *)chart
{
    UIColor * white = [UIColor whiteColor];
    UIColor * green = [UIColor greenColor];
    UIColor * yellow = [UIColor yellowColor];
    return @[white,green,yellow];
}

//Choose line chart range

- (CGRange)WSChartViewChooseRangeInLineChartView:(WSChartView *)chart{
    if (_path.section==0 && (_path.row==0|_path.row==1)) {
    return CGRangeMake(100, 0);
}
    if (_path.section==1 && _path.row==0) {
    return CGRangeMake(100, 0);
}
    f (_path.row==2) {
    return CGRangeMake(100, 0);
}
    return CGRangeZero;
}

#### Features only available for line charts

   //Ability to declare line chart range

- (CGRange)WSChartViewMarkRangeInLineChartView:(WSChartView *)chart
{
    if (_path.row==2) {
    return CGRangeMake(20, 60);
}
    return CGRangeZero;
}
  //Display horizontal line

- (BOOL)WSChartViewShowHorizontalLineAtIndex:(NSInteger)index
{
    return YES;
}
  //Determine the minimum and maximum display
- (BOOL)WSChartViewShowMaxandMinPointAtIndex:(NSInteger)index
{
    return _path.row==2;
}
