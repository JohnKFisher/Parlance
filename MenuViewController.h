//
//  MenuViewController.h
//  Parlance
//
//  Created by John Kenneth Fisher on 7/21/13.
//  Copyright (c) 2013 John Kenneth Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISegmentedControl *roundSelectSegmented;


- (IBAction)roundValueChanged;

@end
