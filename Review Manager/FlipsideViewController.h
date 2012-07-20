//
//  FlipsideViewController.h
//  Review Manager
//
//  Created by enroyed on 7/19/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *tableContainerView;
@property(retain) NSIndexPath* lastIndexPath;

- (IBAction)done:(id)sender;

@end
