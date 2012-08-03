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
#import "MBProgressHUD.h"


@interface QuestionsViewController ()

@end
int a1=0,a2=0,a3=0,a4=0,a5=0; //answers //
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
    
    NSLog(@"%@",userData.userName); //working //
    

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

-(NSMutableString *) convertAnsToString{
    NSMutableString *answers  = [[NSMutableString alloc]init];
    [answers insertString:[NSString stringWithFormat:@"%d",a1] atIndex:0];
    [answers insertString:[NSString stringWithFormat:@"%d",a2] atIndex:1];
    [answers insertString:[NSString stringWithFormat:@"%d",a3] atIndex:2];
    [answers insertString:[NSString stringWithFormat:@"%d",a4] atIndex:3];
    [answers insertString:[NSString stringWithFormat:@"%d",a5] atIndex:4];
    
    
    return answers;
    
    
    
    
    
}

- (IBAction)submitData:(id)sender {
    self.userData.answers = [self convertAnsToString];
    NSLog(@"%@,%@,%@,%@,%@,%@",self.userData.userName,self.userData.userCity,self.userData.userEmail,self.userData.userPhone,self.userData.userComment,self.userData.answers);
    NSURL *url = [NSURL URLWithString:@"http://localhost/php/testPost.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.userData.userName forKey:@"name"];
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
    NSLog(@"Response %d ==> %@", request.responseStatusCode, [request responseString]);
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.delegate = self;
	HUD.labelText = @"Completed";
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:5];
    [self loadHomeView];
}
-(void) showAlert:(NSString *) alert{
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:alert delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok",nil];
    [myAlert show];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    //NSLog(@"%@",error.localizedDescription);
    [self showAlert:error.localizedDescription];
}
@end
