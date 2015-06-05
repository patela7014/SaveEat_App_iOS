//
//  CustomCell.h
//  SaveEat
//
//  Created by  on 11/19/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *restaurantNameLabel;
    IBOutlet UILabel *restaurantAddressLabel;
    IBOutlet UILabel *noOfMilesLabel;
   // IBOutlet UILabel *ratingsLabel;
    IBOutlet UIImageView *thumbnail;
    
    IBOutlet UIImageView *cellImage;
}
@property (retain, nonatomic) IBOutlet UILabel *lblRatingCell;


//@property (nonatomic, retain) IBOutlet UILabel *ratingsLabel;
@property (nonatomic,retain) IBOutlet UIImageView *cellImage;
@property (nonatomic,retain) IBOutlet UILabel *restaurantNameLabel;
@property (nonatomic,retain) IBOutlet UILabel *restaurantAddressLabel;
@property (nonatomic,retain) IBOutlet UILabel *noOfMilesLabel;
@property (nonatomic,retain) IBOutlet UIImageView *thumbnail;
@end
