//
//  DetailResultsVC.h
//  SaveEat
//
//  Created by  on 11/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"

@interface DetailResultsVC : UIViewController <MKMapViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *lblRestaurant;
@property (retain, nonatomic) IBOutlet UILabel *lblRatings;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
@property (retain, nonatomic) IBOutlet UILabel *lblPhone;
@property (retain, nonatomic) IBOutlet UITextView *tvDescription;
@property (retain, nonatomic) IBOutlet MKMapView *map;
@property (retain, nonatomic) IBOutlet UILabel *lblNoMiles;
@property (nonatomic, strong) Restaurant *restaurant;
@property (retain, nonatomic) IBOutlet UITextView *txtPhone;

@end
