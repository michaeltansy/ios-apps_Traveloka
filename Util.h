//
//  Util.h
//  Traveloka
//
//  Created by Ritchie Nathaniel on 3/19/14.
//  Copyright (c) 2014 Traveloka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreLocation/CoreLocation.h>

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0f)
#define RADIANS_TO_DEGREES(x) ((x) * M_PI * 180.0f)

#define IS_IPHONE_4_INCH_AND_ABOVE ([[UIScreen mainScreen] bounds].size.height >= 568)?YES:NO
#define IS_IPHONE_4_7_INCH_AND_ABOVE ([[UIScreen mainScreen] bounds].size.width >= 375)?YES:NO


#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS_8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))

@interface Util : NSObject {
    
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+ (NSString *)nullToEmptyString:(id)value;
+ (NSDictionary *)nullToEmptyDictionary:(id)value;
+ (NSArray *)nullToEmptyArray:(id)value;
+ (UIColor *)getColor:(NSString *)hexColor;
+ (UIImage *)makeRoundCornerImage:(UIImage*)img width:(int)cornerWidth height:(int)cornerHeight;
+ (UIImage *)resizedImage:(UIImage *)inImage frame:(CGRect)thumbRect;
+ (UIImage *)imageByScaling:(BOOL)isScaling cropping:(BOOL)isCropping sourceImage:(UIImage *)sourceImage frame:(CGRect)targetFrame;
+ (NSString *)urlEncodeFromString:(NSString *)sourceString;
+ (NSString *)sha1:(NSString*)input;
+ (NSString *)md5:(NSString *)input;
+ (NSString *)generateRandomStringWithLength:(NSInteger)length;
+ (void)logAllFontFamiliesAndName;
+ (CGFloat)getDistanceFromLong:(double)longitude lat:(double)latitude andLong2:(double)longitude2 lat2:(double)latitude2;
+ (CGRect)getStringConstrainedSizeWithString:(NSString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size;
+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value;
+ (NSString *)jsonStringFromObject:(id)json;
+ (id)jsonObjectFromString:(NSString *)string;
+ (CGFloat)lineMinimumHeight;
+ (CGFloat)screenAdjustedHeight:(CGFloat)currentHeight;
+ (CGFloat)screenAdjustedWidth:(CGFloat)currentWidth;
+ (NSString *)ordinalNumberWithInteger:(NSInteger)number;
+ (UIColor *)colorVerticalGradientFromColor:(UIColor*)firstColor toColor:(UIColor*)secondColor withHeight:(int)height;
+ (UIColor *)colorHorizontalGradientFromColor:(UIColor*)firstColor toColor:(UIColor*)secondColor withWidth:(int)width;

@end
