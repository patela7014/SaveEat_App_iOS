//
//  SearchResultsVC.m
//  SaveEat
//
//  Created by  on 11/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "SearchResultsVC.h"
#import "DetailResultsVC.h"
#import "CustomCell.h"
@interface SearchResultsVC ()

@end

@implementation SearchResultsVC
@synthesize detailsVC;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    restaurantNames=[[NSArray alloc] initWithObjects:@"Restaurant1",@"Restaurant2", nil];
    restaurantAddress=[[NSArray alloc] initWithObjects:@"Address1",@"Address2", nil];
    NumberOfMiles=[[NSArray alloc] initWithObjects:@"0.3",@"0.5", nil];
    
    
    
 //   DetailResultsVC *dViewController = [[DetailResultsVC alloc] initWithNibName:@"DetailResultsVC" bundle:[NSBundle mainBundle]];
//    self.detailsVC = dViewController;
 //   [dViewController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [restaurantNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell= (CustomCell *) currentObject;
                break;
            }
        }
    }
    
        
    cell.restaurantNameLabel=[restaurantNames objectAtIndex:indexPath.row];
    cell.restaurantAddressLabel=[restaurantAddress objectAtIndex:indexPath.row];
    cell.noOfMilesLabel=[NumberOfMiles objectAtIndex:indexPath.row];
    
    return cell;
        
        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
//    }
//    if(indexPath.row == 0)    {
//        cell.textLabel.text = @"Back";
//    }
//    else if(indexPath.row == 1)    {
//        cell.textLabel.text = @"Restaurant 2";
 //   }
 //   else if(indexPath.row == 2)    {
//        cell.textLabel.text = @"Restaurant 3";
//    }
//    else if(indexPath.row == 3)    {
//        cell.textLabel.text = @"Restaurant 4";
//    }
  //  else if(indexPath.row == 4)    {
 //       cell.textLabel.text = @"Restaurant 5";
 //   }
 //   return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)dealloc
{
    [detailsVC release];
    [super dealloc];
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    // Navigation logic may go here, for example:
    // Create the next view controller.
    else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.view addSubview:detailsVC.view];
        [UIView commitAnimations];

        
    }
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
