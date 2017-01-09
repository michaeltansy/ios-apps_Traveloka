//
//  CalendarCollectionViewCell.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/21/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell

- (void)prepareForReuse{
    [super prepareForReuse];
    self.dateLabel.text = @"";
    [self.dateLabel setBackgroundColor:[UIColor whiteColor]];
    [self.dateLabel setTextColor:[UIColor blackColor]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds)/6, CGRectGetWidth([UIScreen mainScreen].bounds)/6)];
        [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
        [self.dateLabel setTextColor:[UIColor blackColor]];
        
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}
@end
