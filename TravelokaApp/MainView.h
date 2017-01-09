//
//  MainView.h
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import "ContentView.h"
@interface MainView : UIView
@property (strong,nonatomic) MenuView *menuView;
@property (strong,nonatomic) ContentView *contentView;
@property (strong,nonatomic) UIView *underline;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIButton *buttonSearch;
@end
