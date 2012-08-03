//
//  QuestionsViewController.h
//  Review Manager
//
//  Created by enroyed on 7/20/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "UserData.h"
#import "MBProgressHUD.h"



@interface QuestionsViewController : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextView *firstQuestion;
@property (weak, nonatomic) IBOutlet UITextView *secondQuestion;
@property (weak, nonatomic) IBOutlet UITextView *thirdQuestion;
@property (weak, nonatomic) IBOutlet UITextView *forthQuestion;
@property (weak, nonatomic) IBOutlet UITextView *fifthQuestion;
@property(weak,nonatomic) NSArray *questions;
@property (nonatomic) UserData *userData;

- (IBAction)submitData:(id)sender;



@end
