//
//  WordsViewController.h
//  Words
//
//  Created by John Kenneth Fisher on 7/15/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParlanceViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *wordLabel;
@property (nonatomic, strong) IBOutlet UIButton *answerTop;
@property (nonatomic, strong) IBOutlet UIButton *answerMiddle;
@property (nonatomic, strong) IBOutlet UIButton *answerBottom;

- (IBAction)topAnswerPressed;
- (IBAction)middleAnswerPressed;
- (IBAction)bottomAnswerPressed;



@end
