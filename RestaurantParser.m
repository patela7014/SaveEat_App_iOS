//
//  RestaurantParser.m
//  SaveEat
//
//  Created by Charan on 12/5/14.
//  Copyright (c) 2014 Charan. All rights reserved.
//

#import "RestaurantParser.h"
#import "Restaurant.h"

@interface RestaurantParser()

@property(nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSString *element;


//Restaurant Properties
@property  NSString *thumbnail;
@property  NSString *restaurantNameLabel;
@property  NSString *restaurantAddressLabel;
@property  NSString *noOfMilesLabel;
@property  NSString *ratingsLabel;
@property  NSString *zipcodeLabel;
@property  NSString *minCostLabel;

@end

@implementation RestaurantParser

- (void)parseXMLData {
    
    NSURL *xmlPath = [[NSBundle mainBundle] URLForResource:@"menu"
                                             withExtension:@"xml"];
    
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlPath];
    self.parser.delegate = self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    self.element = elementName;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    if ([self.element isEqualToString:@"name"]) {
        self.currentName = string;
    }
    else if ([self.element isEqualToString:@"price"]) {
        self.currentPrice = string.doubleValue;
    }
    else if ([self.element isEqualToString:@"description"]) {
        self.currentDescription = string;
    }
    else if ([self.element isEqualToString:@"calories"]) {
        self.currentCalories = string.intValue;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"food"]) {
        Food *thisFood = [[Food alloc] initWithName:self.currentName
                                              price:self.currentPrice
                                    foodDescription:self.currentDescription
                                           calories:self.currentCalories];
        [self.foodArray addObject:thisFood];
    }
    self.element = nil;
}

@end
