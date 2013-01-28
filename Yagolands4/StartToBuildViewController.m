#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"

@interface StartToBuildViewController ()

@end

@implementation StartToBuildViewController

- (void)startToBuildCentroDelVillaggio
{
    Y4AppDelegate * delegate = (Y4AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(delegate.booCentroDelVillaggio == 0) {
        NSLog(@"Inizio a costruire il centro del villaggio.");
        [delegate setEndJobCentroDelVillaggio:[NSDate dateWithTimeIntervalSinceNow:10]];
        [delegate setBooCentroDelVillaggio:true];        
    } else {
        NSLog(@"La costruzione del centro del villaggio terminerà alle %@", delegate.endJobCentroDelVillaggio);
        NSLog(@"Mancano ancora %f secondi", [delegate timeLeftToBuildCentroDelVillaggio]);
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Inizio costruzione"];
        [self startToBuildCentroDelVillaggio];
    }
    return self;
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
