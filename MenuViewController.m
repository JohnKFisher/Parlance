//
//  MenuViewController.m
//  Parlance
//
//  Created by John Kenneth Fisher on 7/21/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

NSInteger totalRounds;

@synthesize roundSelectSegmented;



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
    
    
    // Should make sure the segmented control (named roundSelectSegmented)
    // has the correct one highlighted on load.
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger roundsSegment = [prefs integerForKey:@"roundsSegment"];
    roundSelectSegmented.selectedSegmentIndex = roundsSegment;
    
    if(roundSelectSegmented.selectedSegmentIndex == 0){
		totalRounds = 10;
	}
	if(roundSelectSegmented.selectedSegmentIndex == 1){
        totalRounds = 20;
	}
    if(roundSelectSegmented.selectedSegmentIndex == 2){
        totalRounds = 666;
	}
    
	// Do any additional setup after loading the view.
}




- (void)roundValueChanged


{
    
    //stores selection of how-many-rounds.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    
    if(roundSelectSegmented.selectedSegmentIndex == 0){
		totalRounds = 10;
        [prefs setInteger:0 forKey:@"roundsSegment"];
        [TestFlight passCheckpoint:@"Changedto10Rounds"];

	}
	if(roundSelectSegmented.selectedSegmentIndex == 1){
        totalRounds = 20;
        [prefs setInteger:1 forKey:@"roundsSegment"];
        [TestFlight passCheckpoint:@"Changedto20Rounds"];
	}
    
	if(roundSelectSegmented.selectedSegmentIndex == 2){
        totalRounds = 666;
        [prefs setInteger:2 forKey:@"roundsSegment"];
        [TestFlight passCheckpoint:@"ChangedtoHardcoreMode"];
	}
    
    [prefs setInteger:totalRounds forKey:@"totalRounds"];
    [prefs synchronize];
 
    
}



// -(IBAction)launchFeedback {
//     [TestFlight openFeedbackView];
// }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
