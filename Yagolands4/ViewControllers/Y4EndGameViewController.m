/**
 * Questa è la schermata della fine del gioco.
 */

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
    
    /* Mostro la label di questa cella. */
    UILabel * labelAutore = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 60)];
    [labelAutore setBackgroundColor:[UIColor greenColor]];
    [labelAutore setNumberOfLines:2];
    [labelAutore setTextAlignment:NSTextAlignmentCenter];
    [labelAutore setText:@"Autore: Simone Gentili"];
    [self.view addSubview:labelAutore];
    
    /* Animazione dei titoli di coda. */
    [UIView animateWithDuration:5 animations:^{
        label.frame = CGRectOffset(label.frame, 0, -100);
        labelAutore.frame = CGRectOffset(labelAutore.frame, 0, -100);
        [UIView animateWithDuration:1 animations:^{label.alpha = 0;}];
        [UIView animateWithDuration:1 animations:^{labelAutore.alpha = 0;}];
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
