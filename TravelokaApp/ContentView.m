//
//  ContentView.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "ContentView.h"

@interface ContentView()
@property (strong,nonatomic) UIView *whiteCover;
@end

@implementation ContentView

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
        
        CGFloat labelFontSize = 11.0f;
        CGFloat textFieldFontSize = 20.0f;
    
        _imageOrigin = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetHeight([UIScreen mainScreen].bounds)/50, 25.0f, 25.0f)];
        [self.imageOrigin setImage:[UIImage imageNamed:@"landing-from"]];
        _labelOrigin = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageOrigin.frame)+10.0f, CGRectGetMinY(self.imageOrigin.frame), 50.0f, 20.0f)];
        [self.labelOrigin setText:@"Origin"];
        self.labelOrigin.textColor = [UIColor grayColor];
        [self.labelOrigin setFont:[UIFont fontWithName:@"Arial" size:labelFontSize]];
        _textFieldOrigin = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelOrigin.frame), CGRectGetMaxY(self.labelOrigin.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.textFieldOrigin setText:@"Jakarta (JKTA)"];
        [self.textFieldOrigin setFont:[UIFont fontWithName:@"Arial" size:textFieldFontSize]];
        self.textFieldOrigin.userInteractionEnabled = NO;
        _labelTextFieldOrigin = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelOrigin.frame), CGRectGetMaxY(self.labelOrigin.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.labelTextFieldOrigin setText:@"Jakarta (JKTA)"];
        [self.labelTextFieldOrigin setFont:[UIFont fontWithName:@"Arial" size:textFieldFontSize]];
        
        _buttonExchangeLocation = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-75.0f, CGRectGetMaxY(self.textFieldOrigin.frame), 35.0f, 35.0f)];
        [self.buttonExchangeLocation setImage:[UIImage imageNamed:@"landing-return"] forState:UIControlStateNormal];
        [self.buttonExchangeLocation setBackgroundColor:[UIColor clearColor]];
        
        _imageDestination = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.textFieldOrigin.frame)+20.0f, 20.0f, 20.0f)];
        [self.imageDestination setImage:[UIImage imageNamed:@"landing-to"]];
        _labelDestination = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMinY(self.imageDestination.frame), 80.0f, 20.0f)];
        [self.labelDestination setText:@"Destination"];
        self.labelDestination.textColor = [UIColor grayColor];
        [self.labelDestination setFont:[UIFont fontWithName:@"Arial" size:labelFontSize]];
        _textFieldDestination = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelDestination.frame), CGRectGetMaxY(self.labelDestination.frame)+5.0f,CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.textFieldDestination setText:@"Singapore (SIN)"];
        [self.textFieldDestination setFont:[UIFont fontWithName:@"Arial" size:textFieldFontSize]];
        self.textFieldDestination.userInteractionEnabled = NO;
        _labelTextFieldDestination = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelDestination.frame), CGRectGetMaxY(self.labelDestination.frame)+5.0f,CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.labelTextFieldDestination setText:@"Singapore (SIN)"];
        [self.labelTextFieldDestination setFont:[UIFont fontWithName:@"Arial" size:textFieldFontSize]];
        
        _grayLineDestination = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMaxY(self.textFieldDestination.frame) + 10.0f, CGRectGetMinX(self.buttonExchangeLocation.frame)-5.0f, 1.0f)];
        [self.grayLineDestination setBackgroundColor:[UIColor colorWithRed:0.889 green:0.889 blue:0.889 alpha:1.00]];
        
        _imageDepartureDate = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.grayLineDestination.frame)+10.0f, 20.0f, 20.0f)];
        [self.imageDepartureDate setImage:[UIImage imageNamed:@"icon-calendar"]];
        _labelDepartureDate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDepartureDate.frame)+10.0f, CGRectGetMinY(self.imageDepartureDate.frame), 80.0f, 20.0f)];
        [self.labelDepartureDate setText:@"Departure Date"];
        self.labelDepartureDate.textColor = [UIColor grayColor];
        [self.labelDepartureDate setFont:[UIFont fontWithName:@"Arial" size:labelFontSize]];
        _buttonDepartureDate = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelDepartureDate.frame), CGRectGetMaxY(self.labelDepartureDate.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.buttonDepartureDate setTitle:@"Thursday, 16 Dec 2016" forState:UIControlStateNormal];
        [self.buttonDepartureDate.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
        [self.buttonDepartureDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.buttonDepartureDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.buttonDepartureDate.tag = 0;
        
        _grayLineDepartureDate = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMaxY(self.buttonDepartureDate.frame)+10.0f, CGRectGetMinX(self.buttonExchangeLocation.frame)-5.0f, 1.0f)];
        [self.grayLineDepartureDate setBackgroundColor:[UIColor colorWithRed:0.889 green:0.889 blue:0.889 alpha:1.00]];
        
        _whiteCover = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.grayLineDepartureDate.frame)+1.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 79.0f)];
        [self.whiteCover setBackgroundColor:[UIColor whiteColor]];
        
        _imageRoundTrip = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.grayLineDepartureDate.frame)+30.0f, 15.0f, 15.0f)];
        [self.imageRoundTrip setImage:[UIImage imageNamed:@"icon-arrow-twoway"]];
        _labelRoundTrip = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageRoundTrip.frame)+10.0f, CGRectGetMinY(self.imageRoundTrip.frame), 80.0f, 20.0f)];
        [self.labelRoundTrip setText:@"Round-Trip?"];
        self.labelRoundTrip.textColor = [UIColor grayColor];
        [self.labelRoundTrip setFont:[UIFont fontWithName:@"Arial" size:14.0f]];
        _switchRoundTrip = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/4*3, CGRectGetMaxY(self.labelRoundTrip.frame)-30.0f, 35.0f, 35.0f)];
        [self.switchRoundTrip setOnTintColor:[UIColor colorWithRed:0.106 green:0.627 blue:0.886 alpha:1.00]];
        
        _grayLineRoundTrip = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMaxY(self.labelRoundTrip.frame) + 30.0f, CGRectGetMinX(self.buttonExchangeLocation.frame)-5.0f, 1.0f)];
        [self.grayLineRoundTrip setBackgroundColor:[UIColor colorWithRed:0.889 green:0.889 blue:0.889 alpha:1.00]];
        
        _imageReturnDate = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.grayLineDepartureDate.frame)+10.0f, 20.0f, 20.0f)];
        [self.imageReturnDate setImage:[UIImage imageNamed:@"icon-calendar"]];
        _labelReturnDate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageReturnDate.frame)+10.0f,CGRectGetMinY(self.imageReturnDate.frame), 80.0f, 20.0f)];
        [self.labelReturnDate setText:@"Return Date"];
        self.labelReturnDate.textColor = [UIColor grayColor];
        [self.labelReturnDate setFont:[UIFont fontWithName:@"Arial" size:labelFontSize]];
        _buttonReturnDate = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelReturnDate.frame), CGRectGetMaxY(self.labelReturnDate.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.buttonReturnDate setTitle:@"Saturday, 17 Dec 2016" forState:UIControlStateNormal];
        [self.buttonReturnDate.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
        [self.buttonReturnDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.buttonReturnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.buttonReturnDate.tag = 1;
        
        _grayLineReturnDate = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMaxY(self.buttonReturnDate.frame) + 6.0f, CGRectGetMinX(self.buttonExchangeLocation.frame)-5.0f, 1.0f)];
        [self.grayLineReturnDate setBackgroundColor:[UIColor colorWithRed:0.889 green:0.889 blue:0.889 alpha:1.00]];
        
        _imagePassenger = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/30, CGRectGetMaxY(self.grayLineRoundTrip.frame)+10.0f, 20.0f, 20.0f)];
        [self.imagePassenger setImage:[UIImage imageNamed:@"landing-passanger"]];
        _labelPassenger = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imagePassenger.frame)+10.0f, CGRectGetMinY(self.imagePassenger.frame), 80.0f, 20.0f)];
        [self.labelPassenger setText:@"Passenger"];
        self.labelPassenger.textColor = [UIColor grayColor];
        [self.labelPassenger setFont:[UIFont fontWithName:@"Arial" size:labelFontSize]];
        _textFieldPassenger = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.labelPassenger.frame), CGRectGetMaxY(self.labelPassenger.frame)+5.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/2, 40.0f)];
        [self.textFieldPassenger setText:@"1 Adult"];
        [self.textFieldPassenger setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
        self.textFieldPassenger.userInteractionEnabled = NO;
        
        _grayLinePassenger = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageDestination.frame)+10.0f, CGRectGetMaxY(self.textFieldPassenger.frame) + 10.0f, CGRectGetMinX(self.buttonExchangeLocation.frame)-5.0f, 1.0f)];
        [self.grayLinePassenger setBackgroundColor:[UIColor colorWithRed:0.889 green:0.889 blue:0.889 alpha:1.00]];
        
        [self addSubview:self.imageOrigin];
        [self addSubview:self.labelOrigin];
        [self addSubview:self.textFieldOrigin];
        [self addSubview:self.buttonExchangeLocation];
        [self addSubview:self.imageDestination];
        [self addSubview:self.labelDestination];
        [self addSubview:self.textFieldDestination];
        [self addSubview:self.grayLineDestination];
        [self addSubview:self.imageDepartureDate];
        [self addSubview:self.labelDepartureDate];
        [self addSubview:self.buttonDepartureDate];
        [self addSubview:self.grayLineDepartureDate];
        [self addSubview:self.imageReturnDate];
        [self addSubview:self.labelReturnDate];
        [self addSubview:self.buttonReturnDate];
        [self addSubview:self.grayLineReturnDate];
        [self addSubview:self.whiteCover];
        [self addSubview:self.imageRoundTrip];
        [self addSubview:self.labelRoundTrip];
        [self addSubview:self.switchRoundTrip];
        [self addSubview:self.grayLineRoundTrip];
        [self addSubview:self.imagePassenger];
        [self addSubview:self.labelPassenger];
        [self addSubview:self.textFieldPassenger];
        [self addSubview:self.labelTextFieldOrigin];
        [self addSubview:self.labelTextFieldDestination];
        [self addSubview:self.grayLinePassenger];
    }
    return self;
}

@end
