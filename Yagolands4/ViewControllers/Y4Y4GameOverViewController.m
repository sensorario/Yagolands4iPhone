//
//  Y4Y4GameOverViewController.m
//  Yagolands4
//
//  Created by Simone Gentili on 19/03/13.
//  Copyright (c) 2013 SENSORARIO. All rights reserved.
//

#import "Y4Y4GameOverViewController.h"
#import "Y4AppDelegate.h"

@interface Y4Y4GameOverViewController ()

@end

@implementation Y4Y4GameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Mostro la label di questa cella. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 60)];
    [label setBackgroundColor:[UIColor redColor]];
    [label setNumberOfLines:2];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Hai perso"];
    [self.view addSubview:label];
    
    /* Animazione dei titoli di coda. */
    [UIView animateWithDuration:5 animations:^{
        label.frame = CGRectOffset(label.frame, 0, -100);
        [UIView animateWithDuration:1 animations:^{label.alpha = 0;}];
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
