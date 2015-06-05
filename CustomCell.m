//
//  CustomCell.m
//  SaveEat
//
//  Created by  on 11/19/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize restaurantAddressLabel,restaurantNameLabel,noOfMilesLabel,thumbnail,lblRatingCell,cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    
    [thumbnail release];
    [noOfMilesLabel release];
    [restaurantNameLabel release];
    [restaurantAddressLabel release];
    //[ratingsLabel release];
    [cellImage release];
    [lblRatingCell release];
    [super dealloc];
}
@end
