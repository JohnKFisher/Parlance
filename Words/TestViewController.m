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

NSTimer *hardcoreTimer;
CGFloat currentTimeRemaining;
NSString *currentTimeRemainingString;


@synthesize countdownLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    progress.textColor=[UIColor redColor];
    
    currentTimeRemaining=10;

    
    // Do any additional setup after loading the view, typically from a nib.
    
    hardcoreTimer=[NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

}



-(void)timerFired
{
    
        if(currentTimeRemaining==0.0)
        {
            [hardcoreTimer invalidate];
        }
        else if(currentTimeRemaining>0.0)
        {
            currentTimeRemaining-=0.1;
        }
    
    currentTimeRemainingString = [NSString stringWithFormat:@"%0.1f Seconds Remaining", currentTimeRemaining];
    self.countdownLabel.text = currentTimeRemainingString;

          //  [countdownLabel setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
}



@end