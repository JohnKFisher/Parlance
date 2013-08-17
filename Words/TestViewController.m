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

NSTimer *timer;
CGFloat currentSeconds;
NSInteger startSeconds;
NSString *currentSecondsString;


@synthesize countdownLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    progress.textColor=[UIColor redColor];
    
    startSeconds=10;
    currentSeconds=startSeconds;

    
    // Do any additional setup after loading the view, typically from a nib.
    
    timer=[NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

}



-(void)timerFired
{
    
        if(currentSeconds==0)
        {
            [timer invalidate];
        }
        else if(currentSeconds>0)
        {
            currentSeconds-=0.1;
        }
    
    currentSecondsString = [NSString stringWithFormat:@"%0.1f Seconds Remaining", currentSeconds];
    self.countdownLabel.text = currentSecondsString;

          //  [countdownLabel setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
}



@end