//
//  MainViewController.h
//  Review Manager
//
//  Created by enroyed on 7/19/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import "FlipsideViewController.h"
#import "RateView.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate,RateViewDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextView *comment;


@end
