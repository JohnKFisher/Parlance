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
NSString *lastAnswer;


NSInteger answerLocation;

// Hardcore mode Timer stuff

NSTimer *hardcoreTimer;
CGFloat currentTimeRemaining;
NSString *currentTimeRemainingString;


// The little popup at the end that says if you're right or not.
// I probably don't want this to be an Alert View in the final.

UIAlertView *alertView;


// John - you really gotta figure out what you did wrong and why your boolean didnt work.

NSInteger timerPauseStatus;



@synthesize wordLabel;
@synthesize scoreLabel;
@synthesize answerTop;
@synthesize answerMiddle;
@synthesize answerBottom;
@synthesize countdownTextLabel;
@synthesize countdownTimeLabel;




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepGame];
}




-(void)prepGame

{
    
    
    [self populateArray];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    totalRounds = [prefs integerForKey:@"totalRounds"];
    currentRound = 0;
    currentScore = 0;

    
    if (totalRounds == 666){
        [self startHardcoreGame];
	}
	else {
        [self startGame];
	}
    
    
}


-(void)populateArray
{
    //Pull in Basic Dictionary
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    dictArray = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    //Below loads in "builtin" - will need to be changed when there are more options than this.
    
    availableWords = [dictArray objectForKey:@"Builtin"];
    
}



-(void)startGame

{
    
    [TestFlight passCheckpoint:@"StartedGame"];
    totalRoundsString = [NSString stringWithFormat:@"%d", totalRounds];
    self.countdownTextLabel.hidden = YES;
    self.countdownTimeLabel.hidden = YES;

    [self startWordRound];
    
}

-(void)startHardcoreGame

{
    
    [TestFlight passCheckpoint:@"StartedHardcoreGame"];
    totalRoundsString = @"∞";
    self.countdownTextLabel.hidden = NO;
    self.countdownTimeLabel.hidden = NO;

    hardcoreTimer=[NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    currentTimeRemaining = 10.5;

    [self startHardcoreWordRound];
    
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
    
    [self populateQandA];
}




-(void)startHardcoreWordRound

{
    //increment round and check if the game is done.
    
    currentRound = currentRound+1;
    
    answerTop.backgroundColor = [UIColor whiteColor];
    answerMiddle.backgroundColor = [UIColor whiteColor];
    answerBottom.backgroundColor = [UIColor whiteColor];
    
    
    currentRoundString = [NSString stringWithFormat:@"%d", currentRound];
    completeRoundString = [NSString stringWithFormat:@"%@%@%@%@", @"Round ",currentRoundString, @" of ", totalRoundsString];
    self.roundsLabel.text = completeRoundString;
    
    [self populateQandA];
    
    currentTimeRemaining = 10.1;
    timerPauseStatus = 0;

    

}


-(void)populateQandA
{
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
    
    
    if (availableWords.count >= 5)
    {
        [availableWords removeObjectAtIndex:randomIndexCorrect];
    }
    
    if (availableWords.count <= 4)
    {
        [self populateArray];
    }


}

- (void)topAnswerPressed
{
    
    // checks if the pressed answer is correct. (TODO: break out "correct" and "incorrect" functions)
    
    timerPauseStatus = 1;

    
    if (answerLocation == 0)
    {
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self correctAnswer];
    }
    else if (answerLocation == 1)
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self incorrectAnswer];

    }
    else
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
        [self incorrectAnswer];
    }
    

}


- (void)middleAnswerPressed
{
    
    // checks if the pressed answer is correct.

    timerPauseStatus = 1;
    
    if (answerLocation == 0)
    {
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self incorrectAnswer];
    }
    else if (answerLocation == 1)
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self correctAnswer];
    }
    else
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
        [self incorrectAnswer];
    }
    

}


- (void)bottomAnswerPressed
{
    
    // checks if the pressed answer is correct.
    
    timerPauseStatus = 1;

    
    if (answerLocation == 0)
    {
        answerTop.backgroundColor = [UIColor greenColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self incorrectAnswer];
    }
    else if (answerLocation == 1)
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor greenColor];
        answerBottom.backgroundColor = [UIColor redColor];
        [self incorrectAnswer];

    }
    else
    {
        answerTop.backgroundColor = [UIColor redColor];
        answerMiddle.backgroundColor = [UIColor redColor];
        answerBottom.backgroundColor = [UIColor greenColor];
        [self correctAnswer];
    }
}


- (void)exitButtonPressed
{
    [hardcoreTimer invalidate];
}

-(void)correctAnswer
{
    lastAnswer = @"Correct";
    alertView = [[UIAlertView alloc]
                 initWithTitle:@"Correct!"
                 message:@"Correct!"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
    currentScore = currentScore + 10;
    currentScoreString = [NSString stringWithFormat:@"%d", currentScore];
    completeScoreString = [NSString stringWithFormat:@"%@%@", @"Score: ",currentScoreString];
    self.scoreLabel.text = completeScoreString;
    [alertView show];
}

-(void)incorrectAnswer
{
    lastAnswer = @"Incorrect";
    alertView = [[UIAlertView alloc]
                 initWithTitle:@"Incorrect"
                 message:@"Incorrect"
                 delegate:self
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
    [alertView show];
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (totalRounds == 666 && [lastAnswer  isEqual: @"Incorrect"])
    {
        [self gameOver];
    }
    
    if (totalRounds == 666)
    {
        [self startHardcoreWordRound];
    }
    else
    {
        [self startWordRound];

    }
    
}



-(void)timerFired
{
    
    if (timerPauseStatus == 0)
    {
        
        
        if(currentTimeRemaining<0.1)
        {
            [self gameOver];
        }
        else
        {
            currentTimeRemaining-=0.1;
        }
        
        currentTimeRemainingString = [NSString stringWithFormat:@"%0.2f", currentTimeRemaining];
        self.countdownTimeLabel.text = currentTimeRemainingString;
        
    }
    
 
    
}



-(void)gameOver
{
    
    [hardcoreTimer invalidate];

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

