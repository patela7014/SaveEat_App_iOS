//
//  SearchResultsVC.h
//  SaveEat
//
//  Created by  on 11/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailResultsVC;
@interface SearchResultsVC : UITableViewController
{
    NSArray *restaurantNames;
    NSArray *restaurantAddress;
    NSArray *NumberOfMiles;
    NSArray *ratings;
    
}

@property(nonatomic, retain) DetailResultsVC *detailsVC;
@end
