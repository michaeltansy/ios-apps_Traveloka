//
//  MonthCollectionViewCell.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/21/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "MonthCollectionViewCell.h"

@implementation MonthCollectionViewCell

-(void)prepareForReuse{
    [super prepareForReuse];
    self.monthLabel.text = @"";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 38.0f)];
        [self.monthLabel setTextAlignment:NSTextAlignmentCenter];
        self.monthLabel.textColor = [UIColor colorWithRed:0.259 green:0.682 blue:0.890 alpha:1.00];
        
        [self.contentView addSubview:self.monthLabel];
    }
    return self;
}
@end
