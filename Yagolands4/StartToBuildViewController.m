#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"

@interface StartToBuildViewController ()

@end

@implementation StartToBuildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
        [self setTitle:@"Inizio costruzione"];
        
        if(self.delegate.booCentroDelVillaggio == 0) {
            [self startToBuildCentroDelVillaggio];
        } else {
            NSLog(@"Ho già costruito il Centro del Villaggio.");
        }
    }
    return self;
}

- (void)startToBuildCentroDelVillaggio
{
    [self.delegate setEndJobCentroDelVillaggio:[NSDate dateWithTimeIntervalSinceNow:10]];
    [self.delegate setBooCentroDelVillaggio:true];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mostraTestiDescrittivi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)mostraTestiDescrittivi
{
    /* Mostro la label di questa cella. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 60)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setNumberOfLines:2];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Stai costruendo la tua casa"];
    [self.view addSubview:label];
    
    /* Descrizione della cella in cui si trova l'utente */
    UILabel * labelDescrizione = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
    [labelDescrizione setNumberOfLines:4];
    [labelDescrizione setTextAlignment:NSTextAlignmentCenter];
    [labelDescrizione setText:@"Il centro del villaggio è la tua casa."];
    [self.view addSubview:labelDescrizione];
}

@end
