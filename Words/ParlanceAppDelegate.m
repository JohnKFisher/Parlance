//
//  ParlanceAppDelegate.m
//  Parlance
//
//  Created by John Kenneth Fisher on 7/15/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import "ParlanceAppDelegate.h"

@implementation ParlanceAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    // start of your application:didFinishLaunchingWithOptions
    
    // !!!: Use the next line only during beta
    // [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    
    [TestFlight takeOff:@"41379b40-6272-432b-9de8-b96d6a08b83a"];
    
    [Crashlytics startWithAPIKey:@"d3dc162c597971f16683c5f487ec14a8fb3dae64"];
    
    // (intending to record that the default setting for "roundsSegment" is "0",
	// unless that has already been changed by the user in the past.)
    

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs registerDefaults:@{@"roundsSegment": @"0"}];
    [prefs registerDefaults:@{@"totalRounds": @"10"}];
    [prefs registerDefaults:@{@"hcHighScore": @"0"}];
    [prefs synchronize];
    
    
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
