//
//  RestaurantParser.h
//  SaveEat
//
//  Created by Charan on 12/5/14.
//  Copyright (c) 2014 Charan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantParser : NSObject

@property (nonatomic,retain) NSMutableArray *restaurantArray;

-(void)parseXMLData;

@end
