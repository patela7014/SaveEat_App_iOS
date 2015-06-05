//
//  HomeViewController.m
//  SaveEat
//
//  Created by  on 10/24/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "HomeViewController.h"
#import "SearchResultVC.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize txtBudget,txtPeople,txtZip,budgetSliderOutlet, peopleSliderOutlet,locationManager;
@synthesize viewController, ValidationLbl, ValidationBudgetlbl, ValidationPeoplelbl, ValidationPeopleLabel, ValidationBudgetlabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        SearchResultVC *sViewController = [[SearchResultVC alloc] initWithNibName:@"SearchResultVC" bundle:[NSBundle mainBundle]];
        
        self.viewController = sViewController;
        [sViewController release];
        self.title=@"$ave Eat";

    }
    return self;
}



- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == txtBudget) {
        [txtBudget resignFirstResponder];
    }
    if (theTextField == txtPeople) {
        [txtPeople resignFirstResponder];
    }
    if (theTextField == txtZip) {
        [txtZip resignFirstResponder];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)budgetSliderChanged:(id)sender {
    txtBudget.text=[NSString stringWithFormat:@"%ld", lroundf(self.budgetSliderOutlet.value)];
}

- (IBAction)peopleSliderChanged:(id)sender {
     txtPeople.text=[NSString stringWithFormat:@"%ld", lroundf(self.peopleSliderOutlet.value)];
}

- (IBAction)btnCurrentLocClicked:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    [locationManager startUpdatingLocation];
    
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;

    if (currentLocation != nil) {
        NSDate *todayDate=newLocation.timestamp;
        NSTimeInterval updateTime=[todayDate timeIntervalSinceNow];
        if(abs(updateTime)<5.0)
        {
            [locationManager stopUpdatingLocation];
           [self reverseGeocode:currentLocation];
        }
    }
}

//Determines ZIP Code from Lat and Long
- (void)reverseGeocode:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            txtZip.text =placemark.postalCode;
        }
    }];
}


- (IBAction)btnSearchClicked:(id)sender {
    if(txtZip.text && txtZip.text.length ==0)
    {
        
        ValidationLbl.text = @"Please Enter ZIP Code";
    }
    else if (txtBudget.text && txtBudget.text.length ==0)
    {
        ValidationBudgetlabel.text = @"Please Enter Budget";
        
    }
    else if (txtPeople.text && txtPeople.text.length ==0)
    {
        
        ValidationPeopleLabel.text = @"Please Enter Number Of People";
    }
    else
    {
        
        float cost=txtBudget.text.integerValue/txtPeople.text.integerValue;
        NSDecimalNumber *minCost=[[NSDecimalNumber alloc] initWithFloat:cost];
        viewController.minCostFromVC = minCost;
        viewController.txtZip = txtZip.text;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}
- (void)dealloc {
    [txtBudget release];
    [txtPeople release];
    [txtZip release];
    [budgetSliderOutlet release];
    [peopleSliderOutlet release];
    [locationManager release];
    [viewController release];
  
    [ValidationLbl release];
    [ValidationBudgetlbl release];
    [ValidationPeoplelbl release];
    [ValidationBudgetlabel release];
    [ValidationPeopleLabel release];
    [super dealloc];
}
- (IBAction)txtZipChanged:(id)sender {
    ValidationLbl.text = @"";
}
- (IBAction)txtChangedPeople:(id)sender {
    ValidationPeopleLabel.text=@"";
    
}

- (IBAction)txtChangedBudget:(id)sender {
    
    ValidationBudgetlabel.text=@"";
}
@end
