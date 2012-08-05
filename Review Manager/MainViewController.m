//
//  MainViewController.m
//  Review Manager
//
//  Created by enroyed on 7/19/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "QuestionsViewController.h"
#import "FlipsideViewController.h"
#import "UserData.h"


@interface MainViewController ()

@end
NSArray *questions,*hotels;
int ratingError = 1;


int nameError=1;
int emailError = 1;
int cityError = 1;
int phoneError = 1;
int commentError = 1;


int networkError=0;

NSString *myrating=@"0";
@implementation MainViewController
@synthesize rateView;
@synthesize statusLabel;
@synthesize userName;
@synthesize userEmail;
@synthesize userCity;
@synthesize userPhone;
@synthesize comment;
@synthesize nextButton;
@synthesize userdata;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    myrating = 0;
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    self.comment.layer.masksToBounds=YES;
    self.comment.layer.cornerRadius = 10.0f;
    [self downloaddataFromServer];
   // nextButton.enabled = NO;
   
  
    
    
}

- (void)viewDidUnload
{
    [self setRateView:nil];
    [self setStatusLabel:nil];
    
    [self setComment:nil];
    [self setUserName:nil];
    [self setUserEmail:nil];
    [self setUserCity:nil];
    [self setUserPhone:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   

    
    if ([[segue identifier] isEqualToString:@"showAlternate"])
    {
        [[segue destinationViewController] setDelegate:self];
        FlipsideViewController *fvc = [segue destinationViewController];
        fvc.hotels = hotels;
        
        
        
        
        
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
    
    if ([[segue identifier] isEqualToString:@"next"])
    {
        QuestionsViewController *qvc = [segue destinationViewController];
        qvc.questions = questions;
        userdata = [[UserData alloc]init];
        self.userdata.userName = userName.text;
        self.userdata.userEmail = userEmail.text;
        self.userdata.userCity = userCity.text;
        self.userdata.userPhone = userPhone.text;
        self.userdata.userComment = comment.text;
        self.userdata.rating = myrating;
        qvc.userData = self.userdata;
        
        
        
    }
    
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

//receive the review Using delegate //

- (void)rateView:(RateView *)rateView ratingDidChange:(int)rating {
    //self.statusLabel.text = [NSString stringWithFormat:@"Rating: %d", rating];
    //myrating = rating;
    myrating = [NSString stringWithFormat:@"%d",rating];
    //NSLog(@"%d",myrating);
}

-(void) downloaddataFromServer{
    NSURL *url = [NSURL URLWithString:@"http://review.reputationtec.com/q.php"];
    ASIHTTPRequest *questionsRequest = [ASIHTTPRequest requestWithURL:url];
    questionsRequest.userInfo = [NSDictionary dictionaryWithObject:@"questions" forKey:@"type"];
    [questionsRequest setDelegate:self];
    [questionsRequest startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    /*
    NSString *responseString = [request responseString];
    
    questions = [responseString componentsSeparatedByString:@"~"];
    */
    
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"questions"])
    {
        NSString *responseString = [request responseString];
        questions = [responseString componentsSeparatedByString:@"~"];
        //NSLog(@"%@",questions);  //working !!//
        
        NSURL *hotelsUrl = [NSURL URLWithString:@"http://review.reputationtec.com/branch.php"];
        ASIHTTPRequest *hotelsRequest = [ASIHTTPRequest requestWithURL:hotelsUrl];
        hotelsRequest.userInfo = [NSDictionary dictionaryWithObject:@"hotels" forKey:@"type"];
        [hotelsRequest setDelegate:self];
        [hotelsRequest startAsynchronous];
        
        
        
    }
    
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"hotels"])
    {
        NSString *responseHotels = [request responseString];
        hotels = [responseHotels componentsSeparatedByString:@"~"];
        //working //
        /*
        NSLog(@"second part");
        NSLog(@"%@",hotels);
        */
        
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    networkError = 1;
    NSError *myerror = [request error];
    
    //NSLog(@"%@",error.localizedDescription);
    [self showAlert:myerror.localizedDescription];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
}


-(void) showAlert:(NSString *) alert{
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:alert delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok",nil];
    [myAlert show];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    if (comment.text.length == 0)
    {
        commentError = 1;
        //comment.text = @"[Comment field can't be empty]";
        comment.layer.borderColor= [[UIColor redColor]CGColor];
        comment.layer.borderWidth= 2.0f;
        //comment.textColor = [UIColor redColor];
        
        //[self showAlert:@"Comment field can't be empty"];
        
    }
    else
   {
    commentError = 0;
   }



    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    textView.layer.borderColor = [[UIColor blackColor]CGColor];
    
   
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag ==1)
    {
        textField.layer.borderColor = [[UIColor blackColor]CGColor];
        
        
    }
    
    if (textField.tag ==2)
    {
        textField.layer.borderColor = [[UIColor blackColor]CGColor];
       
        
    }
    
    if (textField.tag ==3)
    {
        textField.layer.borderColor = [[UIColor blackColor]CGColor];
        
        
    }
    if (textField.tag ==4)
    {
        textField.layer.borderColor = [[UIColor blackColor]CGColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        
        
    }
    
    
}
 



- (IBAction)nextPressed:(id)sender {
    [self validateForm];
    
    if (nameError == 1 || emailError ==1 || cityError == 1 || phoneError==1 || commentError ==1)
    {
        [self showAlert:@"Error In form Data"];
    }
    
    else if (networkError==1)
    {
        [self showAlert:@"Network Problem, Please check your Internet Connection"];
    }
    
    else if (ratingError==1)
{
    [self showAlert:@"Please Select a Valid Rating"];
}

else{
    [self performSegueWithIdentifier:@"next" sender:sender];
}


}



-(void) validateForm{
   
    if (self.userName.text.length==0)
    {
        nameError=1;
        self.userName.placeholder=@"[Name field Can't be empty]";
        userName.layer.borderColor = [[UIColor redColor]CGColor];
        userName.layer.borderWidth= 2.0f;
    }
    
    else nameError = 0;
    
    if (self.userEmail.text.length == 0)
    {
        emailError = 1;
        self.userEmail.placeholder = @"[email field Can't be empty]";
        self.userEmail.layer.borderColor=[[UIColor redColor]CGColor];
        self.userEmail.layer.borderWidth= 2.0f;
        
    }
    
    else emailError = 0;
    
    if (self.userCity.text.length == 0)
    {
        cityError = 1;
        self.userCity.placeholder = @"[City field Can't be empty]";
        self.userCity.layer.borderColor=[[UIColor redColor]CGColor];
        self.userCity.layer.borderWidth= 2.0f;
        
    }
    
    else cityError = 0;
    
    
    if (self.userPhone.text.length == 0)
    {
        phoneError = 1;
        self.userPhone.placeholder = @"[Phone field Can't be empty]";
        self.userPhone.layer.borderColor=[[UIColor redColor]CGColor];
        self.userPhone.layer.borderWidth= 2.0f;
        
    }
    
    else phoneError = 0;
    
    if (self.comment.text.length == 0)
    {
        commentError = 1;
        //self.comment.placeholder = @"[Phone field Can't be empty]";
        self.comment.layer.borderColor=[[UIColor redColor]CGColor];
        self.comment.layer.borderWidth= 2.0f;
        
    }
    
    else commentError =0;
    
    if (myrating ==0)
    {
        ratingError = 1;
        //[self showAlert:@"Please Give us a Rating"];
    }
    
    else ratingError = 0;
    
    if ([self validateEmail:self.userEmail.text]==0)
    {
        emailError = 1;

        self.userEmail.placeholder =@"[Email Address is not Valid]";
        self.userEmail.layer.borderColor = [[UIColor redColor]CGColor];
        self.userEmail.layer.borderWidth = 2.0f;
        self.userEmail.text=@"";
        [self.userEmail becomeFirstResponder];
        
        
        
    }
    
    else emailError = 0;
    
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end


