/**
 * Questa è la schermata che mostra l'avvio delle costruzioni.
 */

#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"
#import "Y4TempiDiCostruzione.h"

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
            [self.delegate setEdificioInCostruzione:YES];
        } else {
            if(self.delegate.booCaserma == 0) {
                [self startToBuildCaserma];
                [self.delegate setEdificioInCostruzione:YES];
            }
        }
    }
    return self;
    
}

- (void)startToBuildCentroDelVillaggio
{
    
    /* Recupero il tempo di costruzione del centro del villaggio. */
    Y4TempiDiCostruzione * tempi = [[Y4TempiDiCostruzione alloc] init];
    int tempo = tempi.centroDelvillaggio;
    
    /* Imposto il tempo di costruzione del centro del villaggio. */
    [self.delegate setEndJobCentroDelVillaggio:[NSDate dateWithTimeIntervalSinceNow:tempo]];
    [self.delegate setBooCentroDelVillaggio:true];
    
    /* Mostro il disegno dell'edificio. */
    UIImage * image = [UIImage imageNamed:@"disegno_villaggio.png"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    [self.view addSubview:imageView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
 
    /* Se sto costruendo il centro del villaggio e sto uscendo da questo
     UIViewController, devo impostare self.delegate.oChiusoLaFinestra a YES. */
    if ((int)self.delegate.timeLeftToBuildCentroDelVillaggio > 0) {
        [self.delegate setHoChiusoLaFinestra:YES];
    }
    
    /* Se sto costruendo la caserma e sto uscendo da questo
     UIViewController, devo impostare self.delegate.oChiusoLaFinestra a YES. */
    if ((int)self.delegate.timeLeftToBuildCaserma > 0) {
        [self.delegate setHoChiusoLaFinestra:YES];
    }
    
}

- (void)startToBuildCaserma
{
    
    /* Recupero il tempo di costruzione del centro del villaggio. */
    Y4TempiDiCostruzione * tempi = [[Y4TempiDiCostruzione alloc] init];
    int tempo = tempi.caserma;
    
    /* Imposto il tempo di costruzione del centro del villaggio. */
    [self.delegate setEndJobCaserma:[NSDate dateWithTimeIntervalSinceNow:tempo]];
    [self.delegate setBooCaserma:true];
    
    /* Mostro il disegno dell'edificio. */
    UIImage * image = [UIImage imageNamed:@"disegno_caserma.png"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    [self.view addSubview:imageView];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self mostraTestiDescrittivi];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
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
