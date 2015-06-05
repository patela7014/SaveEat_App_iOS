//
//  Restaurant.h
//  SaveEat
//
//  Created by  on 11/19/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, retain) NSString *thumbnail;
@property (nonatomic, retain) NSString *restaurantNameLabel;
@property (nonatomic, retain) NSString *restaurantAddressLabel;
@property (nonatomic, retain) NSString *noOfMilesLabel;
@property (nonatomic, retain) NSString *ratingsLabel;
@property (nonatomic, retain) NSString *zipcodeLabel;
@property (nonatomic, retain) NSDecimalNumber *minCostLabel;
@property (nonatomic, retain) NSString *cellNumber;
@property (nonatomic, retain) NSString *descriptionRestaurant;
@property (nonatomic, retain) NSString *restaurantId;

/*
-(id)initWithRestaurantName:(NSString *) rName
          restaurantAddress:(NSString *) rAddress
                    ratings:(NSString *) ratings
                    zipcode:(NSString *) zipcode
                    minCost:(NSString *) minCost;*/

@end
