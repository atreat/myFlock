//
//  MYFLLocalTweetViewController.m
//  myFlock
//
//  Created by CSCrew on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MYFLLocalTweetViewController.h"


@implementation MYFLLocalTweetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Search results";
	
	tweetsArray = [[NSMutableArray alloc] init];
	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self getTrendTweet];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	screenNamesArray = [[NSMutableArray alloc] init];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//iOS Dev
	//Horizontal columns, we always want 1
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tweetsArray count];
}

// Customize the appearance of table view cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.5; //returns floating point which will be used for a cell row height at specified row index
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath.row == 0 || indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];		
        cell.backgroundColor = altCellColor;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    //TWTTrendsCustomCell *cell = (TWTTrendsCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 5;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	/*
	 if (cell == nil) {
	 NSArray *topLevelObjects = [[NSBundle mainBundle]
	 loadNibNamed:@"TWTTrendsCustomCell"
	 owner:nil options:nil];
	 for (id currentObject in topLevelObjects) {
	 if ([currentObject isKindOfClass:[UITableViewCell class]]){
	 cell = (TWTTrendsCustomCell *) currentObject;
	 break;
	 }
	 }
	 }*/
    
    // Set up the cell...
	
	/*
	 cell.tweet.text = [[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"tweet"];
	 cell.from.text = [[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"from"];
	 cell.userProfileImage = nil;
	 */
	//cell.backgroundView
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLabel.numberOfLines = 5;
	cell.textLabel.font = [UIFont systemFontOfSize:14.0];
	cell.textLabel.text = [[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"tweet"];
	
	NSURL *url = [NSURL URLWithString:[[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"imageURL"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[[UIImage alloc] initWithData:data] autorelease];
	cell.imageView.image = img;
	
	NSString *from = [[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"from"];
	[screenNamesArray addObject:from];
	NSString *date = [[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"date"];
	NSString *details = [NSString stringWithFormat:@"from: %@ - %@", from, date];
	cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
	cell.detailTextLabel.text = details;
	
	//UIImage *img = [UIImage imageNamed:@"http://a1.twimg.com/profile_images/651290868/081220_091222_normal.JPG"];
	//cell.imageView.image = [UIImageView];
	//NTLNStatus *s = [[NTLNStatus alloc] initWithMessage:[[tweetsArray objectAtIndex:indexPath.row] objectForKey:@"tweet"]];
	//[cell updateCell:s isEven:NO];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	
	NTLNUserTimelineViewController *utvc = [[[NTLNUserTimelineViewController alloc] init] autorelease];
	utvc.screenName = [screenNamesArray objectAtIndex:[indexPath row]];
	[[self navigationController] pushViewController:utvc animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
    [super dealloc];
	[screenNamesArray release];
}


@end
