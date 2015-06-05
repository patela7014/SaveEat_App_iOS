//
//  HomeViewController.h
//  SaveEat
//
//  Created by  on 10/24/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class SearchResultVC;
@interface HomeViewController : UIViewController <CLLocationManagerDelegate,UITextFieldDelegate>


- (IBAction)budgetSliderChanged:(id)sender;
- (IBAction)peopleSliderChanged:(id)sender;
- (IBAction)btnCurrentLocClicked:(id)sender;
- (IBAction)btnSearchClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *ValidationLbl;
@property (retain, nonatomic) IBOutlet UITextField *ValidationBudgetlbl;
@property (retain, nonatomic) IBOutlet UITextField *ValidationPeoplelbl;
- (IBAction)txtChangedPeople:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *ValidationPeopleLabel;

- (IBAction)txtChangedBudget:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *ValidationBudgetlabel;

@property (retain, nonatomic) IBOutlet UISlider *budgetSliderOutlet;
@property (retain, nonatomic) IBOutlet UITextField *txtBudget;
@property (retain, nonatomic) IBOutlet UITextField *txtPeople;
@property (retain, nonatomic) IBOutlet UITextField *txtZip;
@property (retain, nonatomic) IBOutlet UISlider *peopleSliderOutlet;
- (IBAction)txtZipChanged:(id)sender;

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) SearchResultVC *viewController;
@end

