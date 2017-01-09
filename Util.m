//
//  Util.m
//  Traveloka
//
//  Created by Ritchie Nathaniel on 3/19/14.
//  Copyright (c) 2014 Traveloka. All rights reserved.
//

#import "Util.h"

@implementation Util

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate{
    if ([date compare:beginDate] == NSOrderedAscending){
        return NO;
	}
	
    if ([date compare:endDate] == NSOrderedDescending){
        return NO;
	}
	
    return YES;
}

+ (NSString *)nullToEmptyString:(id)value {
    NSString *emptyString = @"";
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyString;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyString;
    }
    
    return (NSString *)value;
}

+ (NSDictionary *)nullToEmptyDictionary:(id)value {
    NSDictionary *emptyDictionary = [NSDictionary dictionary];
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyDictionary;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyDictionary;
    }
    
    return (NSDictionary *)value;
}

+ (NSArray *)nullToEmptyArray:(id)value {
    NSArray *emptyArray = [NSArray array];
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyArray;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyArray;
    }
    
    return (NSArray *)value;
}

+ (UIImage *)resizedImage:(UIImage *)inImage frame:(CGRect)thumbRect {
	CGImageRef imageRef = [inImage CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	// Build a bitmap context that's the size of the thumbRect
	CGContextRef bitmap = CGBitmapContextCreate(
												NULL,
												thumbRect.size.width,		// width
												thumbRect.size.height,		// height
												CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
												4 * thumbRect.size.width,	// rowbytes
												CGImageGetColorSpace(imageRef),
												alphaInfo
												);
	
	// Draw into the context, this scales the image
	CGContextDrawImage(bitmap, thumbRect, imageRef);
	
	// Get an image from the context and a UIImage
	CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}

+ (UIColor *)getColor:(NSString *)hexColor {
	unsigned int red, green, blue;
	
	NSRange range;
	
	range.length = 2;
	
	range.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	
	range.location = 2;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	
	range.location = 4;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
	
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

+ (UIImage *)makeRoundCornerImage:(UIImage*)img width:(int)cornerWidth height:(int)cornerHeight {
    
	int w = img.size.width;
	int h = img.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	CGContextBeginPath(context);
	CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
	addRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
	
	CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *result = [UIImage imageWithCGImage:imageMasked];
	
	CGImageRelease(imageMasked);
	
	return result;
}

+ (UIImage *)imageByScaling:(BOOL)isScaling cropping:(BOOL)isCropping sourceImage:(UIImage *)sourceImage frame:(CGRect)targetFrame {
	CGSize targetSize = targetFrame.size;
	
	CGPoint thumbnailPoint = CGPointMake(0.0f, 0.0f);
	if(isScaling && isCropping)thumbnailPoint = CGPointMake(0.0f, 0.0f);
	else if(isScaling)thumbnailPoint = CGPointMake(0.0f, 0.0f);
	else if(isCropping)thumbnailPoint = CGPointMake(-targetFrame.origin.x, -targetFrame.origin.y);
	
	CGSize imageSize = sourceImage.size;
    
	CGFloat scaledWidth = targetSize.width;
	CGFloat scaledHeight = targetSize.height;
	
	if(isScaling){
		scaledWidth = targetSize.width;
		scaledHeight = targetSize.height;
	}
	else{
		scaledWidth = imageSize.width;
		scaledHeight = imageSize.height;
	}
	
	UIImage *newImage = nil;
	CGFloat scaleFactor = 0.0;
	
	if(isScaling){
		if (CGSizeEqualToSize(imageSize, targetSize) == NO)
		{
			CGFloat widthFactor = targetSize.width / imageSize.width;
			CGFloat heightFactor = targetSize.height / imageSize.height;
			
			if (widthFactor > heightFactor) scaleFactor = widthFactor; //Scale to Fit Witdth
			else scaleFactor = heightFactor; //Scale to Fit Height
			
			scaledWidth  = imageSize.width * scaleFactor;
			scaledHeight = imageSize.height * scaleFactor;
			
			//Center The Image
			if (widthFactor > heightFactor){
				thumbnailPoint.y = (targetSize.height - scaledHeight) * 0.5;
			}
			else{
				if (widthFactor < heightFactor)
				{
					thumbnailPoint.x = (targetSize.width - scaledWidth) * 0.5;
				}
			}
		}
	}
	
	if(isCropping){
		//Crop Image
		UIGraphicsBeginImageContext(targetSize);
		
		CGRect thumbnailRect = CGRectZero;
		thumbnailRect.origin = thumbnailPoint;
		thumbnailRect.size.width  = scaledWidth;
		thumbnailRect.size.height = scaledHeight;
		
		[sourceImage drawInRect:thumbnailRect];
		
		newImage = UIGraphicsGetImageFromCurrentImageContext();
		if(newImage == nil)NSLog(@"Faild to Crop Image");
		
		//Pop Context
		UIGraphicsEndImageContext();
	}
	
	return newImage;
}

+ (NSString *)urlEncodeFromString:(NSString *)sourceString {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[sourceString UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)sha1:(NSString*)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+ (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (NSString *)generateRandomStringWithLength:(NSInteger)length {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    for (int i=0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (void)logAllFontFamiliesAndName {
    NSLog(@"-------------------------------FONT-------------------------------");
    for(NSString *fontFamily in [UIFont familyNames]) {
        NSLog(@"%@", fontFamily);
        
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamily]) {
            NSLog(@"     %@", fontName);
        }
    }
    NSLog(@"------------------------------------------------------------------");
}

+ (CGFloat)getDistanceFromLong:(double)longitude lat:(double)latitude andLong2:(double)longitude2 lat2:(double)latitude2 {
    CLLocation *locationA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *locationB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    
    CLLocationDistance distanceInMeters = [locationA distanceFromLocation:locationB];
    
    return distanceInMeters;
}

+ (CGRect)getStringConstrainedSizeWithString:(NSString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size {
    CGRect countedRect = CGRectZero;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        //iOS 7 and up
        countedRect = [string boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont fontWithName:font.fontName size:font.pointSize]}
                                           context:nil];
    }
    else {
        //Below iOS 7
        CGSize countedSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        countedRect = CGRectMake(0.0f, 0.0f, countedSize.width, countedSize.height);
    }
    
	return countedRect;
}

+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value {
    NSString *valueString = [NSString stringWithFormat:@"%d", value];
    NSString *formattedCurrencyString = @"";
    
    int flag = 0;
    
    for(int i = valueString.length - 1; i>=0; i--) {
        if(flag % 3 == 0 && flag != 0) {
            formattedCurrencyString = [NSString stringWithFormat:@"%c.%@", [valueString characterAtIndex:i], formattedCurrencyString];
        }
        else {
            formattedCurrencyString = [NSString stringWithFormat:@"%c%@", [valueString characterAtIndex:i], formattedCurrencyString];
        }
        
        flag++;
    }
    
    if(currencySign != nil && ![currencySign isEqualToString:@""]) {
        formattedCurrencyString = [NSString stringWithFormat:@"%@ %@", currencySign, formattedCurrencyString];
    }
    
    return formattedCurrencyString;
}

+ (NSString *)jsonStringFromObject:(id)json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"Got an error stringFromJSON method: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id)jsonObjectFromString:(NSString *)string {
    NSError *error;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&error];
    if (!json) {
        NSLog(@"Got an error jsonFromString method: %@", error);
    }
    return json;
}

+ (CGFloat)lineMinimumHeight {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        return 0.5f;
    }
    
    return 1.0f;
}

+ (CGFloat)screenAdjustedHeight:(CGFloat)currentHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds)/568.0f * currentHeight; //Use iPhone 5s as guide
}

+ (CGFloat)screenAdjustedWidth:(CGFloat)currentWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds)/320.0f * currentWidth; //Use iPhone 5s as guide
}

+ (NSString *)ordinalNumberWithInteger:(NSInteger)number {
    id anObject = [NSNumber numberWithInteger:number];
    
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    NSString *strRep = [anObject stringValue];
    NSString *lastDigit = [strRep substringFromIndex:([strRep length]-1)];
    
    NSString *ordinal;
    
    
    if ([strRep isEqualToString:@"11"] || [strRep isEqualToString:@"12"] || [strRep isEqualToString:@"13"]) {
        ordinal = @"th";
    } else if ([lastDigit isEqualToString:@"1"]) {
        ordinal = @"st";
    } else if ([lastDigit isEqualToString:@"2"]) {
        ordinal = @"nd";
    } else if ([lastDigit isEqualToString:@"3"]) {
        ordinal = @"rd";
    } else {
        ordinal = @"th";
    }
    
    return [NSString stringWithFormat:@"%@%@", strRep, ordinal];
}

+ (UIColor *)colorVerticalGradientFromColor:(UIColor*)firstColor toColor:(UIColor*)secondColor withHeight:(int)height {
    CGSize size = CGSizeMake(1.0f, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(0.0f, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)colorHorizontalGradientFromColor:(UIColor*)firstColor toColor:(UIColor*)secondColor withWidth:(int)width {
    CGSize size = CGSizeMake(width, 1.0f);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(size.width, 0.0f), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
