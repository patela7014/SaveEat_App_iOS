//
//  MapAnnotation.h
//  SaveEat
//
//  Created by Ankur Patel on 12/9/14.
//  Copyright (c) 2014 Ankur Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
