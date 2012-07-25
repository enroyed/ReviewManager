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
	
	firstQ.center = CGPointMake(260, 73);
    
    
    // 2st CONTROL
	
	SVSegmentedControl *secondQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
   
    secondQ.changeHandler = ^(NSUInteger newIndex) {
       
        a2= newIndex;
     
    
       NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
   
    
	[self.view addSubview:secondQ];
	
	secondQ.center = CGPointMake(260, 138);
    
    // 3rd CONTROL
	
	SVSegmentedControl *thirdQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    thirdQ.changeHandler = ^(NSUInteger newIndex) {
        a3= newIndex;
       
      
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    
	[self.view addSubview:thirdQ];
	
	thirdQ.center = CGPointMake(260, 200);
    
    
    // 4th CONTROL
	
	SVSegmentedControl *forthQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    
    forthQ.changeHandler = ^(NSUInteger newIndex) {
        a4 = newIndex;
        
        
       
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
   
    
	[self.view addSubview:forthQ];
	
	forthQ.center = CGPointMake(260, 267);
    
    
    // 5th CONTROL
	
	SVSegmentedControl *fifthQ = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    fifthQ.changeHandler = ^(NSUInteger newIndex) {
        a5 = newIndex;
       
        
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        //NSLog(@"%@",self.userData.answers);
       
    };
    
    
    
	[self.view addSubview:fifthQ];
	
	fifthQ.center = CGPointMake(260, 332);
    
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
    NSLog(@"%@",self.userData.answers);
    NSURL *url = [NSURL URLWithString:@"http://localhost/review.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:@"value" forKey:@"key"];
    [request startAsynchronous];
    
    
    
    
   
    
   
}
@end
