//
//  ContentView.h
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/14/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView
@property (strong,nonatomic) UITextField *textFieldOrigin;
@property (strong,nonatomic) UITextField *textFieldDestination;
//@property (strong,nonatomic) UITextField *textFieldDepartureDate;
//@property (strong,nonatomic) UITextField *textFieldReturnDate;
@property (strong,nonatomic) UIButton *buttonDepartureDate;
@property (strong,nonatomic) UIButton *buttonReturnDate;
@property (strong,nonatomic) UITextField *textFieldPassenger;
@property (strong,nonatomic) UISwitch *switchRoundTrip;
@property (strong,nonatomic) UIButton *buttonExchangeLocation;
@property (strong,nonatomic) UILabel *labelOrigin;
@property (strong,nonatomic) UILabel *labelDestination;
@property (strong,nonatomic) UILabel *labelDepartureDate;
@property (strong,nonatomic) UILabel *labelRoundTrip;
@property (strong,nonatomic) UILabel *labelReturnDate;
@property (strong,nonatomic) UILabel *labelPassenger;
@property (strong,nonatomic) UILabel *labelTextFieldOrigin;
@property (strong,nonatomic) UILabel *labelTextFieldDestination;
@property (strong,nonatomic) UIImageView *imageOrigin;
@property (strong,nonatomic) UIImageView *imageDestination;
@property (strong,nonatomic) UIImageView *imageDepartureDate;
@property (strong,nonatomic) UIImageView *imageRoundTrip;
@property (strong,nonatomic) UIImageView *imageReturnDate;
@property (strong,nonatomic) UIImageView *imagePassenger;

@property (strong,nonatomic) UIView *grayLineDestination;
@property (strong,nonatomic) UIView *grayLineDepartureDate;
@property (strong,nonatomic) UIView *grayLineRoundTrip;
@property (strong,nonatomic) UIView *grayLineReturnDate;
@property (strong,nonatomic) UIView *grayLinePassenger;
@end
