//
//  QuestionsViewController.m
//  Review Manager
//
//  Created by enroyed on 7/20/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import "QuestionsViewController.h"
#import "SVSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"
#import "MainViewController.h"



@interface QuestionsViewController ()

@end
int a1=0,a2=0,a3=0,a4=0,a5=0; //answers //
NSString *ans1,*ans2,*ans3,*ans4,*ans5;
NSString *branchName;
@implementation QuestionsViewController
@synthesize firstQuestion;
@synthesize secondQuestion;
@synthesize thirdQuestion;
@synthesize forthQuestion;
@synthesize fifthQuestion;
@synthesize questions;
@synthesize userData;


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
	// Do any additional setup after loading the view.
   // [self loadQuestions];
    
   // NSLog(@"%@",userData.userName); //working //
    [self loadDataFromPlist];
    

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 1st CONTROL
	
	SVSegmentedControl *firstQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    

    firstQ.changeHandler = ^(NSUInteger newIndex) {
        a1=newIndex;
        
        
        
       
       NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
    };
        
	[self.view addSubview:firstQ];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        firstQ.center=CGPointMake(650, 80);
    }
    
    else 
    {
	
	firstQ.center = CGPointMake(260, 73);
    
    }
    // 2st CONTROL
	
	SVSegmentedControl *secondQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
   
    secondQ.changeHandler = ^(NSUInteger newIndex) {
       
        a2= newIndex;
     
    
       NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
   
    
	[self.view addSubview:secondQ];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        secondQ.center=CGPointMake(650, 242);
    }
    
	else{
	secondQ.center = CGPointMake(260, 138);
    }
    
    // 3rd CONTROL
	
	SVSegmentedControl *thirdQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    thirdQ.changeHandler = ^(NSUInteger newIndex) {
        a3= newIndex;
       
      
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    
	[self.view addSubview:thirdQ];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        thirdQ.center=CGPointMake(650, 404);
    }
	
    else{
	thirdQ.center = CGPointMake(260, 200);
    }
    
    // 4th CONTROL
	
	SVSegmentedControl *forthQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    
    forthQ.changeHandler = ^(NSUInteger newIndex) {
        a4 = newIndex;
        
        
       
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
   
    
	[self.view addSubview:forthQ];
	
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
    forthQ.center=CGPointMake(650, 575);
    }
    else{
	forthQ.center = CGPointMake(260, 267);
    }
    
    // 5th CONTROL
	
	SVSegmentedControl *fifthQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    fifthQ.changeHandler = ^(NSUInteger newIndex) {
        a5 = newIndex;
       
        
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        //NSLog(@"%@",self.userData.answers);
       
    };
    
    
    
	[self.view addSubview:fifthQ];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        fifthQ.center=CGPointMake(650, 732);
    }
	else{
	fifthQ.center = CGPointMake(260, 332);
    }
    self.firstQuestion.layer.masksToBounds = YES;
    self.firstQuestion.layer.cornerRadius = 10.0f;
    self.secondQuestion.layer.masksToBounds = YES;
    self.secondQuestion.layer.cornerRadius = 10.0f;
    
    self.thirdQuestion.layer.masksToBounds = YES;
    self.thirdQuestion.layer.cornerRadius = 10.0f;
    
    self.forthQuestion.layer.masksToBounds = YES;
    self.forthQuestion.layer.cornerRadius = 10.0f;
    
    self.fifthQuestion.layer.masksToBounds = YES;
    self.fifthQuestion.layer.cornerRadius = 10.0f;
    
    
    
    //loading the questions //
    firstQuestion.text = [questions objectAtIndex:0];
    secondQuestion.text = [questions objectAtIndex:1];
    thirdQuestion.text = [questions objectAtIndex:2];
    forthQuestion.text = [questions objectAtIndex:3];
    fifthQuestion.text = [questions objectAtIndex:4];
    
    
    
    
    
    
    
   
    
    
    
    
    
    

}

- (void)viewDidUnload
{
    [self setFirstQuestion:nil];
    [self setSecondQuestion:nil];
    [self setThirdQuestion:nil];
    [self setForthQuestion:nil];
    [self setFifthQuestion:nil];
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void) loadDataFromPlist{
    
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
    // assign values
    branchName = [temp objectForKey:@"hotel"];
    //self.phoneNumbers = [NSMutableArray arrayWithArray:[temp objectForKey:@"Phones"]];
    // display values
    //nameEntered.text = personName;
    //homePhone.text = [phoneNumbers objectAtIndex:0];
    //workPhone.text = [phoneNumbers objectAtIndex:1];
    //cellPhone.text = [phoneNumbers objectAtIndex:2];
    //NSLog(@"%@",branchName);
}

-(void) convertAnsToString{
    ans1 = [NSString stringWithFormat:@"%d",a1];
    ans2 = [NSString stringWithFormat:@"%d",a2];
    ans3 = [NSString stringWithFormat:@"%d",a3];
    ans4 = [NSString stringWithFormat:@"%d",a4];
    ans5 = [NSString stringWithFormat:@"%d",a5];
    
    
}




- (IBAction)submitData:(id)sender {
    //self.userData.answers = [self convertAnsToString];
    //NSLog(@"%@,%@,%@,%@,%@,%@,%@",self.userData.userName,self.userData.userCity,self.userData.userEmail,self.userData.userPhone,self.userData.userComment,self.userData.answers,self.userData.rating);
    [self convertAnsToString];
    NSURL *url = [NSURL URLWithString:@"http://review.reputationtec.com/ios.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.userData.userName forKey:@"name"];
    [request addPostValue:self.userData.userEmail forKey:@"email"];
    [request addPostValue:self.userData.userCity forKey:@"city"];
    [request addPostValue:self.userData.userPhone forKey:@"phone"];
    [request addPostValue:self.userData.rating forKey:@"crating"];
    [request addPostValue:self.userData.userComment forKey:@"review"];
    [request addPostValue:branchName forKey:@"branch"];
    [request addPostValue:ans1 forKey:@"q1"];
    [request addPostValue:ans2 forKey:@"q2"];
    [request addPostValue:ans3 forKey:@"q3"];
    [request addPostValue:ans4 forKey:@"q4"];
    [request addPostValue:ans5 forKey:@"q5"];
    [request addPostValue:@"iOS" forKey:@"from"];
    
    [request setDelegate:self];
    [request startSynchronous];
    
    

    
    
    
    
   // [self loadHomeView];
    
    
    
    
    
    
    
    
   
    
   
}

-(void) loadHomeView{
    MainViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"mvc"];
    [self.navigationController pushViewController:mvc animated:YES];
    mvc.navigationItem.leftBarButtonItem = nil;
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
   
    
    UIAlertView *successAlert = [[UIAlertView alloc]initWithTitle:@"Success!!" message:@"Thanks for your Review" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [successAlert show];
    
    
    //[self loadHomeView];
}
-(void) showAlert:(NSString *) alert{
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:alert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok",nil];
    [myAlert show];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    //NSLog(@"%@",error.localizedDescription);
    [self showAlert:error.localizedDescription];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        [self loadHomeView];
    }
}
@end
