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
NSString *highScoreText;



@synthesize finalScoreLabel;
@synthesize highScoreLabel;



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
    
    self.highScoreLabel.hidden = YES;

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger lastScore = [prefs integerForKey:@"lastScore"];
    NSInteger totalRounds = [prefs integerForKey:@"totalRounds"];
    NSInteger prevHighScore = [prefs integerForKey:@"hcHighScore"];
    NSInteger maxScore = totalRounds * 10;
    
    lastScoreString = [NSString stringWithFormat:@"%d", lastScore];
    maxScoreString = [NSString stringWithFormat:@"%d", maxScore];
    
    
    if (totalRounds == 666)
    {
        completeFinalScoreString = [NSString stringWithFormat:@"%@", lastScoreString];
        if (lastScore > prevHighScore)
        {
            highScoreText = @"New High Score!";
            self.highScoreLabel.text = highScoreText;
            self.highScoreLabel.hidden = NO;
            [prefs setInteger:lastScore forKey:@"hcHighScore"];
            [TestFlight passCheckpoint:@"NewHighScore"];
        }
        else
        {
            highScoreText = [NSString stringWithFormat:@"%@%ld", @"Previous High Score: ",(long)prevHighScore];
            self.highScoreLabel.text = highScoreText;
            self.highScoreLabel.hidden = NO;

        }
    
    }
    else
    {
        completeFinalScoreString = [NSString stringWithFormat:@"%@%@%@", lastScoreString, @" / ",maxScoreString];
    }
    
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
