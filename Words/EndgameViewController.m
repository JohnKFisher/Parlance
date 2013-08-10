//
//  EndgameViewController.m
//  Parlance
//
//  Created by John Kenneth Fisher on 8/8/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "EndgameViewController.h"

@interface EndgameViewController ()

@end

@implementation EndgameViewController

NSString *lastScoreString;
NSString *maxScoreString;
NSString *completeFinalScoreString;


@synthesize finalScoreLabel;


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
    

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger lastScore = [prefs integerForKey:@"lastScore"];
    NSInteger totalRounds = [prefs integerForKey:@"totalRounds"];
    NSInteger maxScore = totalRounds * 10;
    
    lastScoreString = [NSString stringWithFormat:@"%d", lastScore];
    maxScoreString = [NSString stringWithFormat:@"%d", maxScore];
    
    completeFinalScoreString = [NSString stringWithFormat:@"%@%@%@", lastScoreString, @" / ",maxScoreString];
    self.finalScoreLabel.text = completeFinalScoreString;

    [TestFlight passCheckpoint:@"FinishedGame"];


    
    
	// Do any additional setup after loading the view.
}



// -(IBAction)launchFeedback {
//    [TestFlight openFeedbackView];
// }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
