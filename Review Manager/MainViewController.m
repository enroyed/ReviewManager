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


@interface MainViewController ()

@end
NSArray *questions,*hotels;
@implementation MainViewController
@synthesize rateView;
@synthesize statusLabel;
@synthesize comment;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    self.comment.layer.masksToBounds=YES;
    self.comment.layer.cornerRadius = 10.0f;
    [self downloaddataFromServer];
  
    
    
}

- (void)viewDidUnload
{
    [self setRateView:nil];
    [self setStatusLabel:nil];
    
    [self setComment:nil];
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
    self.statusLabel.text = [NSString stringWithFormat:@"Rating: %d", rating];
}

-(void) downloaddataFromServer{
    NSURL *url = [NSURL URLWithString:@"http://enroyed.com/projects/iOS/questions.txt"];
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
        
        NSURL *hotelsUrl = [NSURL URLWithString:@"http://enroyed.com/projects/iOS/questions.txt"];
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
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
}











@end
