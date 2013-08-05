//
//  WordsViewController.m
//  Words
//
//  Created by John Kenneth Fisher on 7/15/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "ParlanceViewController.h"

@interface ParlanceViewController ()


@end

@implementation ParlanceViewController

NSString *plistPath;

NSMutableDictionary *dictArray;
NSMutableArray *availableWords;

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

UIAlertView *alertView;


@synthesize wordLabel;
@synthesize answerTop;
@synthesize answerMiddle;
@synthesize answerBottom;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self prepRound];
    
}




-(void)prepRound

{
    
    
    
    
    //Pull in Basic Dictionary
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    dictArray = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    //Below loads in "builtin" - will need to be changed when there are more options than this.
    
    availableWords = [dictArray objectForKey:@"Builtin"];
    
    [self startWordRound];
}



-(void)startWordRound

{
    
    //reset
    
    
    answerTop.backgroundColor = [UIColor whiteColor];
    answerMiddle.backgroundColor = [UIColor whiteColor];
    answerBottom.backgroundColor = [UIColor whiteColor];

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // switch to a background thread and perform your expensive operation
        
        
        
        
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
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // switch back to the main thread to update your UI
            
        });
    });

    
    
    
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
    	[alertView show];
    }
    
    

}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	// Start a new round and show it on the screen.
	[self startWordRound];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

