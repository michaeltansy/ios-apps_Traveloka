//
//  CalendarViewController.h
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/16/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalendarView;
@protocol messageDelegate <NSObject>
-(void)test:(NSString*)str;
@end
@interface CalendarViewController : UIViewController
@property (strong,nonatomic) CalendarView *calendarView;
@property (nonatomic, assign) id <messageDelegate> delegate;
@property (nonatomic) NSInteger checkSection;
@end
