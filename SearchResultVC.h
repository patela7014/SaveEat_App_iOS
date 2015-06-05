//
//  SearchResultVC.h
//  SaveEat
//
//  Created by  on 11/19/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class DetailResultsVC;
@interface SearchResultVC : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate, CLLocationManagerDelegate> 

@property(nonatomic,retain) DetailResultsVC *detailViewController;
@property(nonatomic,retain) NSMutableData *receivedData;

@property(nonatomic, retain) NSString *txtZip;
@property (nonatomic, retain) NSDecimalNumber *minCostFromVC;
@property (retain, nonatomic) IBOutlet UITableView *tblView;



-(void)parseXMLData:(NSData *) XmlData;

@end
