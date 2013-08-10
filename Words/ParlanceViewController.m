//
//  ParlanceViewController.m
//  Parlance
//
//  Created by John Kenneth Fisher on 7/15/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "ParlanceViewController.h"

@interface ParlanceViewController ()


@end

@implementation ParlanceViewController

// Getting the words themselves:

NSString *plistPath;
NSMutableDictionary *dictArray;
NSMutableArray *availableWords;

// Selecting and tracking rounds:

NSInteger totalRounds;
NSInteger currentRound;
NSString *totalRoundsString;
NSString *currentRoundString;
NSString *completeRoundString;

// Tracking Score:

NSInteger currentScore;
NSString *currentScoreString;
NSString *completeScoreString;


// Getting and placing word, and correct/incorrect answers

NSInteger randomIndexCorrect;
NSInteger randomIndexIncorrect1;
NSInteger randomIndexIncorrect2;

NSDictionary *questionCorrect;
NSDictionary *questionIncorrect1;
NSDictionary *questionIncorrect2;

NSString *correctDefinitionStr;
NSString *incorrectDefinitionStr1;
NSString *incorrectDefinitionStr2;

NSString *wordStr;

NSInteger answerLocation;

// The little popup at the end that says if you're right or not.
// I probably don't want this to be an Alert View in the final.

UIAlertView *alertView;



@synthesize wordLabel;
@synthesize scoreLabel;
@synthesize answerTop;
@synthesize answerMiddle;
@synthesize answerBottom;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepRound];
}




-(void)prepRound

{
    //Pull in Basic Dictionary
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    dictArray = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    //Below loads in "builtin" - will need to be changed when there are more options than this.
    
    availableWords = [dictArray objectForKey:@"Builtin"];
    
    [self startGame];
}



-(void)startGame

{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Round select and reset of rounds and score
    
    totalRounds = [prefs integerForKey:@"totalRounds"];
    totalRoundsString = [NSString stringWithFormat:@"%d", totalRounds];
    currentRound = 0;
    currentScore = 0;
    
    [self startWordRound];
}





-(void)startWordRound

{
    //increment round and check if the game is done.
    
    currentRound = currentRound+1;
    if (currentRound > totalRounds)
    {
        [self gameOver];
        
    }
    
    
    
    answerTop.backgroundColor = [UIColor whiteColor];
    answerMiddle.backgroundColor = [UIColor whiteColor];
    answerBottom.backgroundColor = [UIColor whiteColor];
    
    
    currentRoundString = [NSString stringWithFormat:@"%d", currentRound];
    completeRoundString = [NSString stringWithFormat:@"%@%@%@%@", @"Round ",currentRoundString, @" of ", totalRoundsString];
    self.roundsLabel.text = completeRoundString;

    
        //Creates correct question and answer, and two incorrect answers.
        //Do-Whiles make sure answers don't duplicate.
        
        randomIndexCorrect = arc4random() % [availableWords count];
        
        do
        {
            randomIndexIncorrect1 = arc4random() % [availableWords count];
        } while (randomIndexIncorrect1 == randomIndexCorrect);
        
        do
        {
            randomIndexIncorrect2 = arc4random() % [availableWords count];
        } while (randomIndexIncorrect2 == randomIndexCorrect || randomIndexIncorrect2 == randomIndexIncorrect1);
        
    
        
        
        questionCorrect = [availableWords objectAtIndex:randomIndexCorrect];
        questionIncorrect1 = [availableWords objectAtIndex:randomIndexIncorrect1];
        questionIncorrect2 = [availableWords objectAtIndex:randomIndexIncorrect2];
        correctDefinitionStr = [questionCorrect objectForKey:@"Definition"];
        incorrectDefinitionStr1 = [questionIncorrect1 objectForKey:@"Definition"];
        incorrectDefinitionStr2 = [questionIncorrect2 objectForKey:@"Definition"];
        wordStr = [questionCorrect objectForKey:@"Word"];
        answerLocation = arc4random() % 3;
        
    
    
    
    //places above info into the UI
    
    self.wordLabel.text = wordStr;
    

    if (answerLocation == 0)
    {
        [answerTop setTitle:correctDefinitionStr forState:UIControlStateNormal];
        [answerMiddle setTitle:incorrectDefinitionStr1 forState:UIControlStateNormal];
        [answerBottom setTitle:incorrectDefinitionStr2 forState:UIControlStateNormal];
    }
    else if (answerLocation == 1)
    {
        [answerTop setTitle:incorrectDefinitionStr1 forState:UIControlStateNormal];
        [answerMiddle setTitle:correctDefinitionStr forState:UIControlStateNormal];
        [answerBottom setTitle:incorrectDefinitionStr2 forState:UIControlStateNormal];
    }
    else
    {
        [answerTop setTitle:incorrectDefinitionStr1 forState:UIControlStateNormal];
        [answerMiddle setTitle:incorrectDefinitionStr2 forState:UIControlStateNormal];
        [answerBottom setTitle:correctDefinitionStr forState:UIControlStateNormal];
    }
}




- (void)topAnswerPressed
{
    
    // checks if the pressed answer is correct. (TODO: break out "correct" and "incorrect" functions)
    
    if (answerLocation == 0 )
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Correct!"
                                  message:@"Correct!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
        currentScore = currentScore + 10;
        currentScoreString = [NSString stringWithFormat:@"%d", currentScore];
        completeScoreString = [NSString stringWithFormat:@"%@%@", @"Score: ",currentScoreString];
        self.scoreLabel.text = completeScoreString;
    	[alertView show];
    }
    else if (answerLocation == 1)
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
    	[alertView show];
    }
    else
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
    	[alertView show];
    }
}




- (void)middleAnswerPressed
{
    
    // checks if the pressed answer is correct.

    
    if (answerLocation == 0 )
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
    	[alertView show];
    }
    else if (answerLocation == 1)
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Correct!"
                                  message:@"Correct!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
        currentScore = currentScore + 10;
        currentScoreString = [NSString stringWithFormat:@"%d", currentScore];
        completeScoreString = [NSString stringWithFormat:@"%@%@", @"Score: ",currentScoreString];
        self.scoreLabel.text = completeScoreString;
    	[alertView show];
    }
    else
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
    	[alertView show];
    }
}






- (void)bottomAnswerPressed
{
    
    // checks if the pressed answer is correct.

    
    if (answerLocation == 0 )
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
    	[alertView show];
    }
    else if (answerLocation == 1)
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Incorrect"
                                  message:@"Incorrect"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
    	[alertView show];
    }
    else
    {
        alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Correct!"
                                  message:@"Correct!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
        currentScore = currentScore + 10;
        currentScoreString = [NSString stringWithFormat:@"%d", currentScore];
        completeScoreString = [NSString stringWithFormat:@"%@%@", @"Score: ",currentScoreString];
        self.scoreLabel.text = completeScoreString;
    	[alertView show];
    }
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	// Start a new round and show it on the screen.
    
	[self startWordRound];
}



-(void)gameOver
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:currentScore forKey:@"lastScore"];
    [prefs synchronize];
    
    [self performSegueWithIdentifier:@"endgameSegue" sender:self];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

