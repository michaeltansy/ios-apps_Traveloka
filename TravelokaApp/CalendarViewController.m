//
//  CalendarViewController.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/16/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"
#import "MonthCollectionViewCell.h"
#import "CalendarCollectionViewCell.h"

@interface CalendarViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) NSArray *monthArray;
//@property (nonatomic) NSArray *monthAbbrArray;
@property (nonatomic) NSArray *dayArray;

@property (nonatomic) NSMutableDictionary *calendarDictionary;
@property (nonatomic) NSMutableDictionary *monthlyDictionary;
@property (nonatomic) NSInteger indexCalendar;

@property (nonatomic) NSUInteger numDays; //1-31
@property (nonatomic) NSUInteger thisYear;
@property (nonatomic) NSUInteger weekday; //1-7
@property (nonatomic) NSUInteger thisMonth;//1-12

@property (nonatomic) NSInteger currSection;
@property (nonatomic) NSInteger currDate;
@property (nonatomic) NSInteger maxDate;
@property (nonatomic) NSInteger currWeekday;

@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation CalendarViewController
-(void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _monthArray = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    _dayArray = @[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
    
    _indexCalendar = 0;
    [self createCalendar];
    
    //    for(NSInteger i=0;i<self.indexCalendar;i++){
    //        NSLog(@"index : %ld , %@",i,[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",i]]);
    //    }
    
    _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = YES;
    
    UIBarButtonItem *leftBarNavigationItem = [[UIBarButtonItem alloc] init];
    if(self.checkSection==0){
        leftBarNavigationItem.title = @"Departure Date";
    }else{
        leftBarNavigationItem.title = @"Return Date";
    }
    self.navigationItem.leftBarButtonItem = leftBarNavigationItem;
    
    UIBarButtonItem *rightBarNavigationItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(tapClose:)];
    
    
    [rightBarNavigationItem setTitle:@"Close"];
    self.navigationItem.rightBarButtonItem = rightBarNavigationItem;
    
    self.calendarView.calendarCollectionView.delegate = self;
    self.calendarView.calendarCollectionView.dataSource = self;
    
    self.calendarView.monthCollectionView.delegate = self;
    self.calendarView.monthCollectionView.dataSource = self;
    
    _currSection = 0;
    _currDate = 1;
    _maxDate = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"0"]] objectForKey:@"Day"] integerValue];
    _currWeekday = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"0"]] objectForKey:@"Weekday"] integerValue];
    _lastContentOffset = self.calendarView.monthCollectionView.contentOffset.x;
    
    [self.view addSubview:self.calendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

}

//- (void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - NavigationMethods

- (void)tapClose:(UIBarButtonItem *)barItem{
    //    NSLog(@"test");
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    if(collectionView==self.calendarView.monthCollectionView){
        return 24;
    }else if(collectionView==self.calendarView.calendarCollectionView){
        NSInteger day = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",section]] objectForKey:@"Day"] integerValue];
        NSInteger weekday = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",section]] objectForKey:@"Weekday"] integerValue];
        
        CGFloat rows = ceil(((CGFloat)day+(CGFloat)weekday)/7) +1.0f;
        //        NSLog(@"section %ld, %ld", section,(NSInteger)rows*7);
        
        return (NSInteger)rows*7;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger count = 0;
    if(collectionView==self.calendarView.monthCollectionView){
        count = 1;
    }else if(collectionView==self.calendarView.calendarCollectionView){
        count = [self.calendarDictionary count];
        //        count = 1;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    if(self.currSection!=indexPath.section){
        _currSection = indexPath.section;
        _currDate = 1;
        _maxDate = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] objectForKey:@"Day"] integerValue];
        _currWeekday = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] objectForKey:@"Weekday"] integerValue];
    }
    
    if(collectionView == self.calendarView.monthCollectionView){
        
        static NSString *identifier = @"MonthCollectionViewCell";
        
        MonthCollectionViewCell *monthCell = (MonthCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //        }
        NSString *tempMonthText = [[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] objectForKey:@"Month"];
        NSInteger tempYearText = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] objectForKey:@"Year"] integerValue];
        
        NSString *tempLabelText = [NSString stringWithFormat:@"%@ %ld", tempMonthText,tempYearText];
        [monthCell.monthLabel setText:tempLabelText];
        
        return monthCell;
    }
    else if(collectionView == self.calendarView.calendarCollectionView){
        static NSString *identifier = @"CalendarCollectionViewCell";
        
        CalendarCollectionViewCell *calendarCell = (CalendarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSInteger thisWeekday = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]] objectForKey:@"Weekday"] integerValue];
        NSInteger maxDate = [[[self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]] objectForKey:@"Day"] integerValue];
        
        
        if(indexPath.row<7){
            [calendarCell.dateLabel setText:[self.dayArray objectAtIndex:indexPath.row]];
        }else if(indexPath.row-7>=thisWeekday && indexPath.row-7-thisWeekday<maxDate){
            [calendarCell.dateLabel setText:[NSString stringWithFormat:@"%ld",indexPath.row-6-thisWeekday]];
            calendarCell.tag = indexPath.row-6;
        }else{
            [calendarCell.dateLabel setText:@""];
            calendarCell.tag = 0;
        }
        
        if(indexPath.item%7==0){
            [calendarCell.dateLabel setTextColor:[UIColor redColor]];
            calendarCell.tag = 0;
        }
        
        return calendarCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView==self.calendarView.calendarCollectionView){
        CGFloat percentage = 100.0f / self.calendarView.frame.size.width;
    self.calendarView.monthCollectionView.contentOffset = CGPointMake(scrollView.contentOffset.x * percentage, self.calendarView.monthCollectionView.contentOffset.y);
    }
//    else if(scrollView==self.calendarView.calendarCollectionView){
//        NSLog(@"scrolling %f",scrollView.contentOffset.x);
//        self.calendarView.calendarCollectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.calendarView.calendarCollectionView.contentOffset.y);
//    }
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"section : %ld",indexPath.section);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"index path : %ld", indexPath.row-6);
    if(collectionView==self.calendarView.calendarCollectionView){
        CalendarCollectionViewCell *cell = (CalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        NSString *selectedMonth = @"";
        NSString *selectedYear = @"";
        if(indexPath.section<12){
            selectedYear = @"2017";
            selectedMonth = [self.monthArray objectAtIndex:indexPath.section];
        }else{
            selectedYear = @"2018";
            selectedMonth = [self.monthArray objectAtIndex:indexPath.section/2];
        }
        
        NSInteger weekdayNum = indexPath.item%7;
        NSString *hari = @"";
        switch (weekdayNum) {
            case 0:
                hari = @"Sunday";
                break;
            case 1:
                hari = @"Monday";
                break;
            case 2:
                hari = @"Tuesday";
                break;
            case 3:
                hari = @"Wednesday";
                break;
            case 4:
                hari = @"Thursday";
                break;
            case 5:
                hari = @"Friday";
                break;
            case 6:
                hari = @"Saturday";
                break;
        }

        if(![cell.dateLabel.text isEqualToString:@""] && ![cell.dateLabel.text isEqualToString:@"SUN"] && ![cell.dateLabel.text isEqualToString:@"MON"] && ![cell.dateLabel.text isEqualToString:@"TUE"] && ![cell.dateLabel.text isEqualToString:@"WED"] && ![cell.dateLabel.text isEqualToString:@"THU"] && ![cell.dateLabel.text isEqualToString:@"FRI"] && ![cell.dateLabel.text isEqualToString:@"SAT"]){
            [self.delegate test:[NSString stringWithFormat:@"%@, %@ %@ %@", hari,cell.dateLabel.text,selectedMonth,selectedYear]];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }else{
//         MonthCollectionViewCell *cell = (MonthCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//        NSLog(@"month : %@", cell.monthLabel.text);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView==self.calendarView.monthCollectionView){
        return CGSizeMake(100.0f, 40.0f);
    }else if(collectionView==self.calendarView.calendarCollectionView){
        return CGSizeMake(50.0f, 50.0f);
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f; // This is the minimum inter item spacing, can be more
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f; // minimum line spacing
}

#pragma mark - CalendarMethods

-(void) createCalendar{
    NSString *stringDate = @"January 1,2017";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM dd,yyyy"];
    NSDate *currentDate = [dateFormat dateFromString:stringDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    _calendarDictionary = [[NSMutableDictionary alloc] init];
    
    for(NSInteger i=2017;i<2019;i++){
        [components setYear:i];
        for(NSInteger j=1;j<=12;j++){
            _monthlyDictionary = [[NSMutableDictionary alloc] init];
            [components setMonth:j];
            NSDate *date = [calendar dateFromComponents:components];
            NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            NSInteger tempDay = range.length;
            NSString *tempMonth = self.monthArray[j-1];
            NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:date]-1;
            
            [self.monthlyDictionary setObject:[NSNumber numberWithInteger:tempDay] forKey:@"Day"];
            [self.monthlyDictionary setObject:tempMonth forKey:@"Month"];
            [self.monthlyDictionary setObject:[NSNumber numberWithInteger:i] forKey:@"Year"];
            [self.monthlyDictionary setObject:[NSNumber numberWithInteger:weekday] forKey:@"Weekday"];
            
            [self.calendarDictionary setObject:self.monthlyDictionary forKey:[NSString stringWithFormat:@"%ld", self.indexCalendar]];
            
//            NSLog(@"%@", [self.calendarDictionary objectForKey:[NSString stringWithFormat:@"%ld", self.indexCalendar]]);
            
            self.indexCalendar++;
        }
    }
}

@end
