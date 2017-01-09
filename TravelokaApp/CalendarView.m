//
//  CalendarView.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/16/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "CalendarView.h"

@interface CalendarView()
@property (strong,nonatomic) UIView *menuLine;
@end

@implementation CalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _customViewLayout = [[CustomCollectionViewLayout alloc] init];
        _monthFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [self.monthFlowLayout setItemSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/6)];
        [self.monthFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self.monthFlowLayout setSectionInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        
        _monthCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/6) collectionViewLayout:self.monthFlowLayout];
        [self.monthCollectionView setBackgroundColor:[UIColor whiteColor]];
//        [self.monthCollectionView setPagingEnabled:YES];
        [self.monthCollectionView registerClass:[MonthCollectionViewCell class] forCellWithReuseIdentifier:@"MonthCollectionViewCell"];
        [self.monthCollectionView setShowsHorizontalScrollIndicator:NO];
        [self.monthCollectionView setUserInteractionEnabled:NO];
        
        _menuLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.monthCollectionView.frame)+1.5f, self.monthCollectionView.frame.size.width, 2.0f)];
        [self.menuLine setBackgroundColor:[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]];
        
        _scheduleUnderline = [[UIView alloc] initWithFrame:CGRectMake(12.0f, CGRectGetMaxY((self.monthCollectionView.frame))+1.5f, 75.0f, 2.0f)];
        [self.scheduleUnderline setBackgroundColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
        
        _calendarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.menuLine.frame)+2.0f, CGRectGetWidth([UIScreen mainScreen].bounds), (CGRectGetHeight([UIScreen mainScreen].bounds)/2)+50.0f) collectionViewLayout:self.customViewLayout];
        [self.calendarCollectionView setBackgroundColor:[UIColor whiteColor]];
        [self.calendarCollectionView setPagingEnabled:YES];
        [self.calendarCollectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
        [self.calendarCollectionView setShowsHorizontalScrollIndicator:NO];
        
        [self addSubview:self.monthCollectionView];
        [self addSubview:self.menuLine];
        [self addSubview:self.scheduleUnderline];
        [self addSubview:self.calendarCollectionView];
    }
    return self;
}

@end
