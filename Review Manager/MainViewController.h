//
//  MainViewController.h
//  Review Manager
//
//  Created by enroyed on 7/19/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import "FlipsideViewController.h"
#import "RateView.h"
#include "UserData.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate,RateViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userCity;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextView *comment;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic) UserData *userdata;


@end
