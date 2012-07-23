//
//  FlipsideViewController.m
//  Review Manager
//
//  Created by enroyed on 7/19/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import "FlipsideViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FlipsideViewController ()

@end
NSString *mySelectedHotel;
int againtouched=0; //because of Table view //
@implementation FlipsideViewController
@synthesize tableContainerView;
@synthesize lastIndexPath;
@synthesize hotels;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableContainerView.layer.masksToBounds=YES;
    tableContainerView.layer.cornerRadius= 10.0f;
    
    
    //load plist data //
    
    
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    // convert static property liost into dictionary object
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp)
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
   // NSLog(@"%@",temp);
    mySelectedHotel  = [temp objectForKey:@"hotel"];
    
       
    
}



- (void)viewDidUnload
{
    [self setTableContainerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
    againtouched = 0;  //because of Table view //
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    cell.textLabel.text = [hotels objectAtIndex:indexPath.row];
     
    
        
    
    
    
   
    if ([indexPath compare:lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //save the data //
        //[self saveData:[hotels objectAtIndex:indexPath.row]];
        
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
  
    
    if ([cell.textLabel.text isEqualToString:mySelectedHotel] && againtouched == 0)
    {
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
        //NSLog(@"%d",indexPath.row);
        
        
        
    }
    
    

    

    
    
    
    return cell;
}

-(void) saveData:(NSString *) selectedHotel
{
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    // set the variables to the values in the text fields
    NSString *selectedHotels = selectedHotel;
    //NSLog(@"%@",selectedHotels);
   
    
    // create dictionary with values in UITextFields
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: selectedHotels,nil] forKeys:[NSArray arrayWithObjects: @"hotel",nil]];
    
    NSString *error = nil;
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData)
    {
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
        //NSLog(@"data written successfully");
    }
    else
    {
        NSLog(@"Error in saveData: %@", error);
        
    }
     
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastIndexPath = indexPath;
    [self saveData:[hotels objectAtIndex:indexPath.row]];
    againtouched = 1;
    
    
    
    
    
    
    [tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [hotels count];
}









@end
