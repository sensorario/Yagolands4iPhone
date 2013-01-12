//
//  MainViewController.m
//  Yagolands4
//
//  Created by Simone Gentili on 12/01/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    NSLog(@"Hai caricato il MainViewController");
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 440, 40)];
    [label setText:@"Wellcome to Yagolands4iPhone"];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
