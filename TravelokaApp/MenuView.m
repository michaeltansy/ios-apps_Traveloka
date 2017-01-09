//
//  MenuView.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

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
        
        _ButtonOptionHotel = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height/2+5.0f, self.frame.size.width/3, self.frame.size.height/2)];
        [self.ButtonOptionHotel setTitle:@"Hotel" forState:UIControlStateNormal];
        [self.ButtonOptionHotel setTitleColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00] forState:UIControlStateNormal];
        [self.ButtonOptionHotel.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [self.ButtonOptionHotel setBackgroundColor:[UIColor blackColor]];
        self.ButtonOptionHotel.tag = 1;
        
        _buttonOptionFlight = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ButtonOptionHotel.frame), self.frame.size.height/2+5.0f, self.frame.size.width/3, self.frame.size.height/2)];
        [self.buttonOptionFlight setTitle:@"Flight" forState:UIControlStateNormal];
        [self.buttonOptionFlight setTitleColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00] forState:UIControlStateNormal];
        [self.buttonOptionFlight.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonOptionFlight.tag = 2;
//        [self.buttonOptionFlight setBackgroundColor:[UIColor blueColor]];
        
        _buttonOptionMyBooking = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buttonOptionFlight.frame), self.frame.size.height/2+5.0f, self.frame.size.width/3, self.frame.size.height/2)];
        [self.buttonOptionMyBooking setTitle:@"My Booking" forState:UIControlStateNormal];
        [self.buttonOptionMyBooking setTitleColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00] forState:UIControlStateNormal];
        [self.buttonOptionMyBooking.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [self.buttonOptionMyBooking setBackgroundColor:[UIColor greenColor]];
        self.buttonOptionMyBooking.tag = 3;
        
        [self addSubview:self.ButtonOptionHotel];
        [self addSubview:self.buttonOptionFlight];
        [self addSubview:self.buttonOptionMyBooking];
    }
    return self;
}

@end
