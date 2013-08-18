//
//  ParlanceViewController.h
//  Parlance
//
//  Created by John Kenneth Fisher on 7/15/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParlanceViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *wordLabel;
@property (nonatomic, strong) IBOutlet UILabel *roundsLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;


@property (nonatomic, strong) IBOutlet UIButton *answerTop;
@property (nonatomic, strong) IBOutlet UIButton *answerMiddle;
@property (nonatomic, strong) IBOutlet UIButton *answerBottom;


@property (nonatomic, strong) IBOutlet UILabel *countdownTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *countdownTimeLabel;

// @property (assign) BOOL pauseStatus;



- (IBAction)topAnswerPressed;
- (IBAction)middleAnswerPressed;
- (IBAction)bottomAnswerPressed;
- (IBAction)exitButtonPressed;



@end
