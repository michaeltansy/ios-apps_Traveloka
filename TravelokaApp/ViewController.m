//
//  ViewController.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "CalendarViewController.h"
#import "ViewController.h"
@interface ViewController ()
@property (nonatomic) CGFloat menuHotelPosition;
@property (nonatomic) CGFloat menuFlightPosition;
@property (nonatomic) CGFloat menuMyBookingPosition;

@property (strong,nonatomic) CalendarViewController *calendarViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = YES;
    
    UIBarButtonItem *leftBarNavigationItem = [[UIBarButtonItem alloc] init];
    leftBarNavigationItem.title = @"Promo";
    self.navigationItem.leftBarButtonItem = leftBarNavigationItem;
    [self.mainView.menuView.ButtonOptionHotel addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"Traveloka";
    [self.mainView.menuView.buttonOptionFlight addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarNavigationItem = [[UIBarButtonItem alloc] init];
    rightBarNavigationItem.image = [UIImage imageNamed:@"icon-more"];
    self.navigationItem.rightBarButtonItem = rightBarNavigationItem;
    [self.mainView.menuView.buttonOptionMyBooking addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView.contentView.buttonExchangeLocation addTarget:self action:@selector(changeOriginDestination) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.contentView.switchRoundTrip addTarget:self action:@selector(roundTripSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [self.mainView.contentView.buttonDepartureDate addTarget:self action:@selector(tapSchedule:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.contentView.buttonReturnDate addTarget:self action:@selector(tapSchedule:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView.contentView.labelTextFieldOrigin.alpha = 0.0f;
    self.mainView.contentView.labelTextFieldDestination.alpha = 0.0f;
//    self.mainView.contentView.imageReturnDate.alpha = 0.0f;
//    self.mainView.contentView.labelReturnDate.alpha = 0.0f;
//    self.mainView.contentView.buttonReturnDate.alpha = 0.0f;
//    self.mainView.contentView.grayLineReturnDate.alpha = 0.0f;
    self.mainView.menuView.ButtonOptionHotel.alpha = 0.5f;
    self.mainView.menuView.buttonOptionMyBooking.alpha = 0.5f;
    
    [self.view addSubview:self.mainView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CustomMethods

- (void)selectMenu: (UIButton *)button{
    CGFloat buttonWidthSelected = 0.0f;
    if(button.tag==1){
        NSLog(@"Hotel");
        self.mainView.menuView.ButtonOptionHotel.alpha = 1.0f;
        self.mainView.menuView.buttonOptionFlight.alpha = 0.5f;
        self.mainView.menuView.buttonOptionMyBooking.alpha = 0.5f;
        buttonWidthSelected = CGRectGetWidth([Util getStringConstrainedSizeWithString:[self.mainView.menuView.ButtonOptionHotel  titleForState:UIControlStateNormal] withFont:self.mainView.menuView.ButtonOptionHotel.titleLabel.font withConstrainedSize:self.mainView.menuView.ButtonOptionHotel.bounds.size]);
        _menuHotelPosition = (CGRectGetMaxX(self.mainView.menuView.ButtonOptionHotel.frame)/2)-(buttonWidthSelected/2);
        [UIView animateWithDuration:0.5f animations:^{
            self.mainView.underline.frame = CGRectMake(self.menuHotelPosition, CGRectGetMaxY(self.mainView.menuView.frame)+1.5f, buttonWidthSelected, 25.0f);
        }];
    }else if(button.tag==2){
        NSLog(@"Flight");
        self.mainView.menuView.ButtonOptionHotel.alpha = 0.5f;
        self.mainView.menuView.buttonOptionFlight.alpha = 1.0f;
        self.mainView.menuView.buttonOptionMyBooking.alpha = 0.5f;
        buttonWidthSelected = CGRectGetWidth([Util getStringConstrainedSizeWithString:[self.mainView.menuView.buttonOptionFlight  titleForState:UIControlStateNormal] withFont:self.mainView.menuView.buttonOptionFlight.titleLabel.font withConstrainedSize:self.mainView.menuView.buttonOptionFlight.bounds.size]);
        
        _menuFlightPosition = self.mainView.menuView.buttonOptionFlight.frame.size.width/2 + self.mainView.menuView.ButtonOptionHotel.frame.size.width - buttonWidthSelected/2;
        
        
        [UIView animateWithDuration:0.5f animations:^{
            self.mainView.underline.frame = CGRectMake(self.menuFlightPosition, CGRectGetMaxY(self.mainView.menuView.frame)+1.5f, buttonWidthSelected, 25.0f);
        }];
    }else if(button.tag==3){
        NSLog(@"My Booking");
        self.mainView.menuView.ButtonOptionHotel.alpha = 0.5f;
        self.mainView.menuView.buttonOptionFlight.alpha = 0.5f;
        self.mainView.menuView.buttonOptionMyBooking.alpha = 1.0f;
        buttonWidthSelected = CGRectGetWidth([Util getStringConstrainedSizeWithString:[self.mainView.menuView.buttonOptionMyBooking  titleForState:UIControlStateNormal] withFont:self.mainView.menuView.buttonOptionMyBooking.titleLabel.font withConstrainedSize:self.mainView.menuView.buttonOptionMyBooking.bounds.size]);
        _menuMyBookingPosition = self.mainView.menuView.buttonOptionMyBooking.frame.size.width/2 + self.mainView.menuView.ButtonOptionHotel.frame.size.width*2 - buttonWidthSelected/2;
        
        [UIView animateWithDuration:0.5f animations:^{
            self.mainView.underline.frame = CGRectMake(self.menuMyBookingPosition, CGRectGetMaxY(self.mainView.menuView.frame)+1.5f, buttonWidthSelected, 25.0f);
        }];
    }
}

- (void)changeOriginDestination{
    NSString *origin = self.mainView.contentView.textFieldOrigin.text;
    self.mainView.contentView.textFieldOrigin.alpha = 0.0f;
    self.mainView.contentView.textFieldDestination.alpha = 0.0f;
    self.mainView.contentView.labelTextFieldOrigin.alpha = 1.0f;
    self.mainView.contentView.labelTextFieldDestination.alpha = 1.0f;
    
    [self.mainView.contentView.buttonExchangeLocation setUserInteractionEnabled:NO];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.mainView.contentView.labelTextFieldOrigin.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelOrigin.frame), CGRectGetMaxY(self.mainView.contentView.labelDestination.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
        [self.mainView.contentView.textFieldOrigin setText:self.mainView.contentView.textFieldDestination.text];
        [self.mainView.contentView.labelTextFieldOrigin setText:self.mainView.contentView.textFieldDestination.text];
        self.mainView.contentView.labelTextFieldOrigin.alpha = 0.0f;
//        self.mainView.contentView.textFieldOrigin.alpha = 1.0f;
        
        self.mainView.contentView.labelTextFieldDestination.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelDestination.frame), CGRectGetMaxY(self.mainView.contentView.labelOrigin.frame)+5.0f,CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
        [self.mainView.contentView.textFieldDestination setText:origin];
        [self.mainView.contentView.labelTextFieldDestination setText:origin];
        self.mainView.contentView.labelTextFieldDestination.alpha = 0.0f;
//        self.mainView.contentView.textFieldDestination.alpha = 1.0f;
        
        CGAffineTransform transform = self.mainView.contentView.buttonExchangeLocation.imageView.transform;
        CGAffineTransform new_transform = CGAffineTransformRotate(transform, M_PI);
        self.mainView.contentView.buttonExchangeLocation.imageView.transform = new_transform;
    } completion:^(BOOL finished) {
        self.mainView.contentView.textFieldOrigin.alpha = 1.0f;
        self.mainView.contentView.textFieldDestination.alpha = 1.0f;
        self.mainView.contentView.labelTextFieldOrigin.alpha = 0.0f;
        self.mainView.contentView.labelTextFieldDestination.alpha = 0.0f;
        
        self.mainView.contentView.labelTextFieldOrigin.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelOrigin.frame), CGRectGetMaxY(self.mainView.contentView.labelOrigin.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
        self.mainView.contentView.labelTextFieldDestination.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelDestination.frame), CGRectGetMaxY(self.mainView.contentView.labelDestination.frame)+5.0f,CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
        
        self.mainView.contentView.labelTextFieldOrigin.text = self.mainView.contentView.textFieldOrigin.text;
        self.mainView.contentView.labelTextFieldDestination.text = self.mainView.contentView.textFieldDestination.text;
        
        [self.mainView.contentView.buttonExchangeLocation setUserInteractionEnabled:YES];
    }];
}

- (void)roundTripSwitch:(UISwitch *)roundTrip{
    NSLog(@"switch : %d",[roundTrip isOn]);
    [self.mainView.contentView.switchRoundTrip setUserInteractionEnabled:NO];
//    if([roundTrip isOn]){
        [UIView animateWithDuration:0.5f animations:^{
            if([roundTrip isOn]){
                self.mainView.contentView.imageReturnDate.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.mainView.contentView.grayLineRoundTrip.frame)+10.0f, 20.0f, 20.0f);
                self.mainView.contentView.labelReturnDate.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageReturnDate.frame)+10.0f,CGRectGetMinY(self.mainView.contentView.imageReturnDate.frame), 80.0f, 20.0f);
                self.mainView.contentView.buttonReturnDate.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelReturnDate.frame), CGRectGetMaxY(self.mainView.contentView.labelReturnDate.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
                self.mainView.contentView.grayLineReturnDate.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageDestination.frame)+10.0f, CGRectGetMaxY(self.mainView.contentView.buttonReturnDate.frame) + 10.0f, CGRectGetMinX(self.mainView.contentView.buttonExchangeLocation.frame)-5.0f, 1.0f);
                
                self.mainView.contentView.imagePassenger.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.mainView.contentView.grayLineReturnDate.frame)+10.0f, 20.0f, 20.0f);
                self.mainView.contentView.labelPassenger.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imagePassenger.frame)+10.0f, CGRectGetMinY(self.mainView.contentView.imagePassenger.frame), 80.0f, 20.0f);
                self.mainView.contentView.textFieldPassenger.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelPassenger.frame), CGRectGetMaxY(self.mainView.contentView.labelPassenger.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
                self.mainView.contentView.grayLinePassenger.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageDestination.frame)+10.0f, CGRectGetMaxY(self.mainView.contentView.textFieldPassenger.frame) + 10.0f, CGRectGetMinX(self.mainView.contentView.buttonExchangeLocation.frame)-5.0f, 1.0f);
                self.mainView.scrollView.scrollEnabled = YES;
//                self.mainView.contentView.imageReturnDate.alpha = 1.0f;
//                self.mainView.contentView.labelReturnDate.alpha = 1.0f;
//                self.mainView.contentView.buttonReturnDate.alpha = 1.0f;
//                self.mainView.contentView.grayLineReturnDate.alpha = 1.0f;
            }else{
                self.mainView.contentView.imageReturnDate.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.mainView.contentView.grayLineDepartureDate.frame)+10.0f, 20.0f, 20.0f);
                self.mainView.contentView.labelReturnDate.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageReturnDate.frame)+10.0f,CGRectGetMinY(self.mainView.contentView.imageReturnDate.frame), 80.0f, 20.0f);
                self.mainView.contentView.buttonReturnDate.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelReturnDate.frame), CGRectGetMaxY(self.mainView.contentView.labelReturnDate.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
                self.mainView.contentView.grayLineReturnDate.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageDestination.frame)+10.0f, CGRectGetMaxY(self.mainView.contentView.buttonReturnDate.frame) + 6.0f, CGRectGetMinX(self.mainView.contentView.buttonExchangeLocation.frame)-5.0f, 1.0f);
                
                self.mainView.contentView.imagePassenger.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.mainView.contentView.grayLineRoundTrip.frame)+10.0f, 20.0f, 20.0f);
                self.mainView.contentView.labelPassenger.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imagePassenger.frame)+10.0f, CGRectGetMinY(self.mainView.contentView.imagePassenger.frame), 80.0f, 20.0f);
                self.mainView.contentView.textFieldPassenger.frame = CGRectMake(CGRectGetMinX(self.mainView.contentView.labelPassenger.frame), CGRectGetMaxY(self.mainView.contentView.labelPassenger.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f);
                self.mainView.contentView.grayLinePassenger.frame = CGRectMake(CGRectGetMaxX(self.mainView.contentView.imageDestination.frame)+10.0f, CGRectGetMaxY(self.mainView.contentView.textFieldPassenger.frame) + 10.0f, CGRectGetMinX(self.mainView.contentView.buttonExchangeLocation.frame)-5.0f, 1.0f);
                self.mainView.scrollView.scrollEnabled = NO;
//                self.mainView.contentView.imageReturnDate.alpha = 0.0f;
//                self.mainView.contentView.labelReturnDate.alpha = 0.0f;
//                self.mainView.contentView.buttonReturnDate.alpha = 0.0f;
//                self.mainView.contentView.grayLineReturnDate.alpha = 0.0f;
            }
        } completion:^(BOOL finished) {
                [self.mainView.contentView.switchRoundTrip setUserInteractionEnabled:YES];
            }];
//    }
    
}

- (void)tapSchedule:(UIButton *)button{
    NSLog(@"button : %ld",button.tag);
//    NSLog(@"button title : %@", button.titleLabel.text);
    _calendarViewController = [[CalendarViewController alloc] init];
    UINavigationController *navigationController2 =
    [[UINavigationController alloc] initWithRootViewController:self.calendarViewController];
    self.calendarViewController.delegate = self;
    if(button.tag==0){
        self.calendarViewController.checkSection = 0;
        
    }else if(button.tag==1){
        self.calendarViewController.checkSection = 1;
    }
    [self presentViewController:navigationController2 animated:YES completion:^{
        
    }];
}

-(void) test:(NSString*)str{
    NSLog(@"test %@",str);
    if(self.calendarViewController.checkSection==0){
        [self.mainView.contentView.buttonDepartureDate setTitle:str forState:UIControlStateNormal];
    }else{
        [self.mainView.contentView.buttonReturnDate setTitle:str forState:UIControlStateNormal];
    }
}


@end
