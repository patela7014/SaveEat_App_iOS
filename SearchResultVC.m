//
//  SearchResultVC.m
//  SaveEat
//
//  Created by  on 11/19/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "SearchResultVC.h"
#import "Restaurant.h"
#import "CustomCell.h"
#import "DetailResultsVC.h"
#import "HomeViewController.h"


@interface SearchResultVC ()

@property(nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSString *element;


//Restaurant Properties
@property (nonatomic,copy) NSString *curRestaurantNameLabel;
@property (nonatomic,copy) NSString *curRestaurantAddressLabel;
@property (nonatomic,copy) NSString *curRatingsLabel;
@property (nonatomic,copy) NSString *curZipcodeLabel;
@property (nonatomic, copy) NSDecimalNumber *curMinCostLabel;
@property (nonatomic, copy) NSString *curCellNumb;
@property (nonatomic, copy) NSString *descriptionRestaurant;
@property (nonatomic,copy) NSString *restaurantID;
@end

@implementation SearchResultVC

@synthesize detailViewController, receivedData, tblView;
@synthesize txtZip,minCostFromVC;
NSInteger counter=0;
//int countForNoOfRows = 0;
NSMutableArray *restaurantArray, *resultsArray, *filteredArray;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
     restaurantArray=[[NSMutableArray alloc]init];
    //Create NSURL object
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sceweb.sce.uhcl.edu/buddharaju/Restaurants.xml"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!theConnection) {
        // Release the receivedData object.
        self.receivedData = nil;
    }
    
    return self;
}
-(void)dealloc
{
    [minCostFromVC release];
    [txtZip release];
    [detailViewController release];
    //[tableView release];
    [tblView release];
    [super dealloc];
}


- (void)viewDidLoad
{
    //[self filterSearchResults];
    [super viewDidLoad];
    self.title=@"Restaurants";
    
    // Do any additional setup after loading the view from its nib.
}



-(void)viewDidAppear:(BOOL)animated
{
    [self filterSearchResults];
    [self.tblView reloadData];
    //[UITableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma XML Parsing
- (void)parseXMLData:(NSData*) XmlData{
    
    self.parser = [[NSXMLParser alloc] initWithData:XmlData];
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
    
    if ([self.element isEqualToString:@"Name"]) {
        self.curRestaurantNameLabel = string;
    }
    else if ([self.element isEqualToString:@"Address"]) {
        self.curRestaurantAddressLabel = string;
    }
    else if ([self.element isEqualToString:@"Zipcode"]) {
        self.curZipcodeLabel = string;
    }
    else if ([self.element isEqualToString:@"minCost"]) {
        self.curMinCostLabel = [NSDecimalNumber decimalNumberWithString:string];
    }
    else if ([self.element isEqualToString:@"Rating"]) {
        self.curRatingsLabel = string;
    }
    else if ([self.element isEqualToString:@"Mobile"]) {
        self.curCellNumb = string;
    }
    else if ([self.element isEqualToString:@"Description"]) {
        self.descriptionRestaurant = string;
    }
    else if ([self.element isEqualToString:@"Restaurant_Id"]) {
        self.restaurantID = string;
    }
    
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"Restaurant"]) {
        
        
        Restaurant *thisRestaurant=[[Restaurant alloc] init];
        thisRestaurant.restaurantNameLabel = NSLocalizedString(self.curRestaurantNameLabel, @"restaurantNameLabel");
        thisRestaurant.restaurantAddressLabel=self.curRestaurantAddressLabel;
        //thisRestaurant.noOfMilesLabel = distance;
        thisRestaurant.ratingsLabel= NSLocalizedString(self.curRatingsLabel,@"ratingsLabel");
        thisRestaurant.zipcodeLabel= NSLocalizedString(self.curZipcodeLabel,@"zipcodeLabel");
        thisRestaurant.minCostLabel=  self.curMinCostLabel;
        thisRestaurant.cellNumber = NSLocalizedString(self.curCellNumb, @"cellNumber");
        thisRestaurant.descriptionRestaurant = NSLocalizedString(self.descriptionRestaurant, @"descriptionRestaurant");
        thisRestaurant.restaurantId = NSLocalizedString(self.restaurantID, @"restaurantId");
        //thisRestaurant.restaurantId = (NSString *) counter;
    
    [restaurantArray insertObject:thisRestaurant atIndex:counter];
        counter=counter+1;
        
        
    }
    self.element = nil;
}


-(void)getDistance:(NSString *)sourcePoint
{
    int count=0;
    while (count<filteredArray.count) {
        Restaurant *curRestaurant=[filteredArray objectAtIndex:count];
    
    // Get Distance between user current location and restaurant Address
    NSString *lookUpString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&units=%@", sourcePoint, curRestaurant.restaurantAddressLabel, @"imperial"];
    
    lookUpString = [lookUpString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];
    
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    
    NSArray *distanceArray = [[[jsonDict valueForKey:@"rows"] valueForKey:@"elements"] valueForKey:@"distance"];
    
    distanceArray = [distanceArray objectAtIndex:0];
    NSString *distance = [[distanceArray valueForKey:@"text"] componentsJoinedByString:@""];
        curRestaurant.noOfMilesLabel=distance;
        [filteredArray replaceObjectAtIndex:count withObject:curRestaurant];
    //return distance;
        count++;
    }
}

#pragma mark - NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   // NSString *responseString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
   
    NSLog(@"Response recieved:");
    [self parseXMLData:receivedData];
     self.receivedData = nil;
    NSLog(@"Parsing Complete");
    NSLog(@"Arraylength:%lu",(unsigned long)restaurantArray.count);
    //[self filterSearchResults];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
     NSLog(@"Connection failed: %@", [error description]);
}

-(void) filterSearchResults
{
    //NSString *zipcode=self.txtZip;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zipcodeLabel=%@",self.txtZip];
           // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zipcodeLabel= %@","77058"];
    NSPredicate *minCostPredicate = [NSPredicate predicateWithFormat:@"minCostLabel <= %f", [minCostFromVC doubleValue]];
    filteredArray=[[[restaurantArray filteredArrayUsingPredicate:predicate] filteredArrayUsingPredicate:minCostPredicate]mutableCopy];
    //Populate distance values
    [self getDistance:self.txtZip];
    
    //sort the array
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"noOfMilesLabel"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [filteredArray sortedArrayUsingDescriptors:sortDescriptors];
    resultsArray=[sortedArray mutableCopy];
}
#pragma mark - tableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [resultsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   // countForNoOfRows++;
   // NSLog(@"no of rows are :%d",  countForNoOfRows);
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
       NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (CustomCell *)currentObject;
                break;
            }
        }
    }
    
    // Configure the cell.
    Restaurant *restaurant = [resultsArray objectAtIndex:indexPath.row];
    //cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Restaurant.jpg"]];
   cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",restaurant.restaurantId]];
                            cell.restaurantNameLabel.text = restaurant.restaurantNameLabel;
    cell.restaurantAddressLabel.text = restaurant.restaurantAddressLabel;
    
    
    cell.noOfMilesLabel.text = restaurant.noOfMilesLabel;
    //cell.noOfMilesLabel.text = [self getDistance:self.txtZip :restaurant.restaurantAddressLabel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblRatingCell.text = restaurant.ratingsLabel;
        NSLog(@"%@ %@ %@",restaurant.restaurantNameLabel, restaurant.zipcodeLabel, restaurant.minCostLabel);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController)
        self.detailViewController = [[DetailResultsVC alloc] initWithNibName:@"DetailResultsVC" bundle:nil];
    
    Restaurant *restaurant = [resultsArray objectAtIndex:indexPath.row];
    self.detailViewController.restaurant = restaurant;
 //   self.detailViewController.context = self.fetchedResultsController.managedObjectContext;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end