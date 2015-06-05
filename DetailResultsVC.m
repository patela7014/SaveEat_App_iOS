//
//  DetailResultsVC.m
//  SaveEat
//
//  Created by  on 11/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "DetailResultsVC.h"
#import "MapAnnotation.h"

@interface DetailResultsVC ()

@end

@implementation DetailResultsVC

@synthesize restaurant,lblAddress,lblNoMiles,lblPhone,lblRatings,lblRestaurant,map,tvDescription,txtPhone;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Details";
     self.map.mapType = MKMapTypeStandard;
    // Do any additional setup after loading the view from its nib.
    
    // We are delegate for map view
    self.map.delegate = self;
}


- (CLLocationCoordinate2D)addressLocation
{
    NSError *error = nil;
    
    NSString *lookUpString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", self.restaurant.restaurantAddressLabel];
    
    lookUpString = [lookUpString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    
    NSArray *locationArray = [[[jsonDict valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"];
    
    locationArray = [locationArray objectAtIndex:0];
    
    NSString *latitudeString = [locationArray valueForKey:@"lat"];
    NSString *longitudeString = [locationArray valueForKey:@"lng"];
    
    NSLog(@"LatitudeString:%@ & LongitudeString:%@", latitudeString, longitudeString);
    
    NSString *statusString = [jsonDict valueForKey:@"status"];
    
    NSLog(@"JSON Response Status:%@", statusString);
    
    CLLocationCoordinate2D location;
    
    double latitude = 0.0;
    double longitude = 0.0;
    
    if ([statusString isEqualToString:@"OK"])
    {
        latitude = [latitudeString doubleValue];
        longitude = [longitudeString doubleValue];
    }
    
    else
        NSLog(@"Something went wrong, couldn't find address");
    
    
    location.longitude = longitude;
    location.latitude = latitude;
    
    return location;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureView];
}

- (void)configureView
{
    if (self.restaurant)
    {
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        
        CLLocationCoordinate2D location = [self addressLocation];
        
        region.span = span;
        region.center = location;
        
        // Make a map annotation for a pin from the longitude/latitude points
        MapAnnotation *mapPoint = [[[MapAnnotation alloc] init] autorelease];
        mapPoint.coordinate = CLLocationCoordinate2DMake(location.latitude,location.longitude);
        mapPoint.title = self.restaurant.restaurantNameLabel;
        mapPoint.subtitle = self.restaurant.restaurantAddressLabel;
        
        // Add it to the map view
        [self.map addAnnotation:mapPoint];

        [self.map setRegion:region animated:YES];
        [self.map regionThatFits:region];
        
        
        
        self.lblRestaurant.text = self.restaurant.restaurantNameLabel;
        self.lblAddress.text = self.restaurant.restaurantAddressLabel;
        self.lblNoMiles.text = self.restaurant.noOfMilesLabel;
        self.txtPhone.text = self.restaurant.cellNumber;
        self.tvDescription.text = self.restaurant.descriptionRestaurant;
        self.lblRatings.text = self.restaurant.ratingsLabel;
        
        self.txtPhone.editable=NO;
        
        self.txtPhone.dataDetectorTypes=UIDataDetectorTypePhoneNumber;
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [restaurant release];
    [lblRestaurant release];
    [lblRatings release];
    [lblAddress release];
    [lblPhone release];
    [tvDescription release];
    [map release];
    [lblNoMiles release];
    [txtPhone release];
    [super dealloc];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *view = nil;
    static NSString *reuseIdentifier = @"MapAnnotation";
    // Return a MKPinAnnotationView with a simple accessory button
    view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        view.canShowCallout = YES;
        view.animatesDrop = YES;
    }
    return view;
}
@end
