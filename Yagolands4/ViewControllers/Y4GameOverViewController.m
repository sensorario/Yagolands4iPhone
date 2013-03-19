#import "Y4GameOverViewController.h"
#import "Y4AppDelegate.h"

@interface Y4GameOverViewController ()

@end

@implementation Y4GameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    /* Richiamo il costruttore per avere il delegate. */
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

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

@end
