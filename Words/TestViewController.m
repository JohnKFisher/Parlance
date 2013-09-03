//
//  TestViewController.m
//  Parlance
//
//  Created by John Kenneth Fisher on 8/17/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController


NSString *plistPath;
NSMutableDictionary *dictArray;
NSMutableArray *availableWords;
NSInteger numberOfWords;
NSString *numberOfWordsString;




@synthesize countdownLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"Dictionary" ofType:@"plist"];
    dictArray = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    //Below loads in "builtin" - will need to be changed when there are more options than this.
    
    availableWords = [dictArray objectForKey:@"Builtin"];
    numberOfWords = [availableWords count];

    numberOfWordsString = [NSString stringWithFormat:@"%d", numberOfWords];
    self.countdownLabel.text = numberOfWordsString;



    
    // Do any additional setup after loading the view, typically from a nib.
    

}


@end