//
//  MainView.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "MainView.h"
#import <QuartzCore/QuartzCore.h>

@interface MainView()<UIScrollViewDelegate>
@property (strong,nonatomic) UIView *menuLine;
@end

@implementation MainView

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
//        NSLog(@"Main Viewframe : %f", self.frame.size.height);
        _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/6)];
        
        CGFloat buttonWidthSelected = CGRectGetWidth([Util getStringConstrainedSizeWithString:[self.menuView.buttonOptionFlight  titleForState:UIControlStateNormal] withFont:self.menuView.buttonOptionFlight.titleLabel.font withConstrainedSize:self.menuView.buttonOptionMyBooking.bounds.size]);
        
        _underline = [[UIView alloc] initWithFrame:CGRectMake(165.0f, CGRectGetMaxY(self.menuView.frame)+1.5f, buttonWidthSelected, 25.0f)];
        [self.underline setBackgroundColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
        
        _menuLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.menuView.frame)+1.5f, CGRectGetWidth([UIScreen mainScreen].bounds), 25.0f)];
        [self.menuLine setBackgroundColor:[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]];
    
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMinY(self.underline.frame)+2.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-(self.menuView.frame.size.height + 60.0f))];
        self.scrollView.showsVerticalScrollIndicator = YES;
//        self.scrollView.showsHorizontalScrollIndicator = YES;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 530.0f);
        
        _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 530.0f)];
        [self.scrollView addSubview:self.contentView];
        
        _buttonSearch = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, CGRectGetMaxY(self.scrollView.frame)+7.0f, CGRectGetWidth([UIScreen mainScreen].bounds)-20.0f, 40.0f)];
        [self.buttonSearch setTitle:@"SEARCH" forState:UIControlStateNormal];
        [self.buttonSearch setBackgroundColor:[UIColor colorWithRed:0.976 green:0.482 blue:0.047 alpha:1.00]];
        [self.buttonSearch setTintColor:[UIColor whiteColor]];
        [self.buttonSearch.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonSearch.layer.cornerRadius = 6.0f;
        self.buttonSearch.layer.borderWidth = 1.0f;
        self.buttonSearch.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self addSubview:self.menuView];
        [self addSubview:self.menuLine];
        [self addSubview:self.underline];
        [self addSubview:self.scrollView];
        [self addSubview:self.buttonSearch];
    }
    return self;
}

@end
