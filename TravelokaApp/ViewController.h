//
//  ViewController.h
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewController.h"
@class MainView;
@interface ViewController : UIViewController<messageDelegate>
@property (strong,nonatomic) MainView *mainView;
@property (strong,nonatomic) NSString *departureDateData;
@end

