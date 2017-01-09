//
//  CalendarView.h
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/16/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewLayout.h"
#import "MonthCollectionViewCell.h"
#import "CalendarCollectionViewCell.h"

@interface CalendarView : UIView
@property (strong,nonatomic) UILabel *labelDate;
@property (strong,nonatomic) CustomCollectionViewLayout *customViewLayout;
@property (strong,nonatomic) UICollectionViewFlowLayout *monthFlowLayout;
@property (strong,nonatomic) UICollectionView *calendarCollectionView;
@property (strong,nonatomic) UICollectionView *monthCollectionView;
@property (strong,nonatomic) UIView *scheduleUnderline;
@end
