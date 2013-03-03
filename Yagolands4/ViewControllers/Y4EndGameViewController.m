//
//  Y4EndGameViewController.m
//  Yagolands4
//
//  Created by Simone Gentili on 03/03/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import "Y4EndGameViewController.h"

@interface Y4EndGameViewController ()

@end

@implementation Y4EndGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Fine gioco");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Mostro la label di questa cella. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 60)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setNumberOfLines:2];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Congratualzioni!!! Hai completato il gioco."];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
