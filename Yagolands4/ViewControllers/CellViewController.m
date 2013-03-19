/**
 * Qui è possibile vedere il dettaglio della cella. In basso, saranno visibili
 * i bottoni degli edifici che si possono costruire.
 */

#import "CellViewController.h"
#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"
#import "Y4LandaDesolata.h"
#import "Y4CentroDelVillaggio.h"
#import "Y4Caserma.h"
#import "Y4EndGameViewController.h"
#import "Y4TempiDiCostruzione.h"

@interface CellViewController ()

@end

@implementation CellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
    }
    return self;
    
}

- (void)threadCountDown:(id)sender
{
    
    if(self.delegate.edificioInCostruzione == YES) {
        
        int secondi = 0;
        
        if((int)self.delegate.timeLeftToBuildCentroDelVillaggio >= 0) {
            
            /* Calcolo dei secondi rimanenti per il centro del villaggio. */
            secondi = (int)self.delegate.timeLeftToBuildCentroDelVillaggio;
            NSString * string = [NSString stringWithFormat:@"Mancano %d secondi.", secondi];
            [self.labelInContruzione setText:string];
            
        } else {
            
            if((int)self.delegate.timeLeftToBuildCaserma >= 0) {
                
                /* Calcolo i secondi rimanenti per la Caserma. */
                secondi = (int)self.delegate.timeLeftToBuildCaserma;
                NSString * string = [NSString stringWithFormat:@"Mancano %d secondi.", secondi];
                
                /* Aggiungo la label altrimenti non visibile. */
                self.labelCasermaInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
                [self.labelCasermaInContruzione setTextAlignment:NSTextAlignmentLeft];
                [self.labelCasermaInContruzione setTag:101];
                [self.labelCasermaInContruzione setText:string];
                [self.view addSubview:self.labelCasermaInContruzione];
                
            }
            
        }
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
        [self.timerCountdown invalidate];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.timerCountdown invalidate];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if(!self.timerCountdown) {
        if((int)self.delegate.timeLeftToBuildCentroDelVillaggio > 0 ||
           (int)self.delegate.timeLeftToBuildCaserma > 0) {
            self.timerCountdown = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                   target:self
                                                                 selector:@selector(threadCountDown:)
                                                                 userInfo:nil
                                                                  repeats:YES];
        }
    }
    
    if([self.delegate giocoFinito]==YES) {
        
            //Y4EndGameViewController * controller = [[Y4EndGameViewController alloc] init];
            //self.delegate.window.rootViewController = controller;
        
    } else {
    
        [self mostraTestiDescrittivi];
        [self mostroAzioniDisponibili];
        
        Y4LandaDesolata * landaDesolata = [[Y4LandaDesolata alloc] init];
        [self setTitle:[landaDesolata getName]];
        [((UITextView *)[self.view viewWithTag:102]) setText:[landaDesolata getLocation]];
        [((UITextView *)[self.view viewWithTag:103]) setText:[landaDesolata getDescription]];
        
        if(self.delegate.idCentroDelVillaggio && (self.delegate.idCentroDelVillaggio) == self.idCell) {
            Y4CentroDelVillaggio * centro = [[Y4CentroDelVillaggio alloc] init];
            [self setTitle:[centro getName]];
            [((UITextView *)[self.view viewWithTag:102]) setText:[centro getLocation]];
            [((UITextView *)[self.view viewWithTag:103]) setText:[centro getDescription]];
        }
        
        if(self.delegate.idCaserma && (self.delegate.idCaserma) == self.idCell) {
            Y4Caserma * caserma = [[Y4Caserma alloc] init];
            [self setTitle:[caserma getName]];
            [((UITextView *)[self.view viewWithTag:102]) setText:[caserma getLocation]];
            [((UITextView *)[self.view viewWithTag:103]) setText:[caserma getDescription]];
        }
        
    }
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.labelInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
    [self.labelInContruzione setTextAlignment:NSTextAlignmentLeft];
    [self.labelInContruzione setTag:101];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

- (void)mostraTestiDescrittivi
{
    
    [self showLabeldLandaDesolata];
    [self showDescrizioneLandaDesolata];
    
}

- (void)mostroAzioniDisponibili
{
    
    [self showLabelPuoiCostruire];
    
    /* Centro del Villaggio. */
    if([self centroDelVillaggionNotExists]) {
        [self mostraBottonePerCostruireIlCentroDelVillaggio];
    }
    if((int)self.delegate.timeLeftToBuildCentroDelVillaggio > 0) {
        [self removeButtonForBuildCentroDelVillaggio];
        [self showLabelCentroDelVillaggioInCostruzione];
    }
    
    /* Caserma. */
    if([self centroDelVillaggionExists] && [self isCentroDelVillaggioCostruito]) {
        if(!(self.delegate.idCaserma > 0)) {
            [self mostraBottonePerCostruireLaCaserma];
        }
    }
    if ((int)self.delegate.timeLeftToBuildCaserma > 0) {
        [self removeButtonForBuildCaserma];
        [self showLabelCasermaInCostruzione];
    }
    
}

# pragma mark Utility methods

- (void)showDescrizioneLandaDesolata
{
    
    UILabel * labelDescrizione = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
    [labelDescrizione setNumberOfLines:4];
    [labelDescrizione setTextAlignment:NSTextAlignmentCenter];
    [labelDescrizione setText:@"Questa è una landa desolata, un luogo edificabile in cui è possibile fondare il proprio villaggio."];
    [labelDescrizione setTag:103];
    [self.view addSubview:labelDescrizione];
    
}

- (void)showLabeldLandaDesolata
{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Landa Desolata"];
    [label setTag:102];
    [self.view addSubview:label];
    
}

- (void)costruisciCentroDelVillaggio
{
    
    [self startTimerToBuildCentroDelVillaggio];
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    self.delegate.idCentroDelVillaggio = !self.delegate.idCentroDelVillaggio ? self.idCell : 0;
    [self.navigationController pushViewController:controller animated:true];
    
}

- (void)costruisciCaserma
{
    
    if(self.delegate.idCaserma == 0) {
        
        if(self.delegate.idCentroDelVillaggio != self.idCell) {
            
            /* Faccio partire la costruzione della caserma. */
            [self startTimerToBuildCaserma];
            StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
            self.delegate.idCaserma = !self.delegate.idCaserma ? self.idCell : 0;
            [self.navigationController pushViewController:controller animated:true];
            
        } else {
            
            /* Non posso costruire più edifici sulla stessa cella. */
            [[[UIAlertView alloc] initWithTitle:@"IMPOSSIBILE COSTRUIRE"
                                        message:@"Non puoi costruire più edifici sulla stessa cella."
                                       delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil] show];

        }
        
    }
    
}

- (void)threadCostruisciCaserma:(NSTimer *)theTimer
{
    
    if(self.delegate.idCaserma != 0 && [self isCasermaCostruita]) {

        /* Ho terminato di costruire la caserma. */
        [self.delegate setEdificioInCostruzione:NO];
        [self.delegate setGiocoFinito:YES];
        [self.delegate setIdEdificioCorrente:self.delegate.idCaserma];
        [theTimer invalidate];
        theTimer = nil;
        
        Y4EndGameViewController * controller = [[Y4EndGameViewController alloc] init];
        self.delegate.window.rootViewController = controller;
        
        [self.delegate setHoChiusoLaFinestra:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        if(self.delegate.hoChiusoLaFinestra == NO) {
            
            /* Recupero il tempo di costruzione della caserma. */
            Y4TempiDiCostruzione * tempi = [[Y4TempiDiCostruzione alloc] init];
            if ((int)tempi.caserma - 3 > (int)self.delegate.timeLeftToBuildCaserma) {
                [self.delegate setHoChiusoLaFinestra:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }

        [self.delegate setEdificioInCostruzione:YES];
        
    }
    
}

- (void)threadCostruisciCentroDelVillaggio:(NSTimer *)theTimer
{
    
    if(self.delegate.idCentroDelVillaggio != 0 &&  [self isCentroDelVillaggioCostruito]) {
        
        /* Ho terminato di costruire il centro del villaggio. */
        [self.delegate setEdificioInCostruzione:NO];
        [self.delegate setIdEdificioCorrente:self.delegate.idCentroDelVillaggio];
        [theTimer invalidate];
        theTimer = nil;
        
        [self.delegate setHoChiusoLaFinestra:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        if(self.delegate.hoChiusoLaFinestra == NO) {
            
            /* Recupero il tempo di costruzione del centro del villaggio. */
            Y4TempiDiCostruzione * tempi = [[Y4TempiDiCostruzione alloc] init];
            if ((int)tempi.centroDelvillaggio - 3 > (int)self.delegate.timeLeftToBuildCentroDelVillaggio) {
                [self.delegate setHoChiusoLaFinestra:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
        [self.delegate setEdificioInCostruzione:YES];
        
    }
    
}

- (void)showLabelPuoiCostruire
{
    
    /* Mostro la label che dice che puoi costruire. */
    UILabel * labelCostruzioni = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 280, 40)];
    [labelCostruzioni setTextAlignment:NSTextAlignmentLeft];
    [labelCostruzioni setText:@"Che cosa puoi costruire:"];
    [self.view addSubview:labelCostruzioni];
    
}

- (void)startTimerToBuildCentroDelVillaggio
{
    
    self.timerCentroDelVillaggio = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(threadCostruisciCentroDelVillaggio:)
                                                                  userInfo:nil
                                                                   repeats:YES];
    
}

- (void)startTimerToBuildCaserma
{
    
    self.timerCaserma = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(threadCostruisciCaserma:)
                                                       userInfo:nil
                                                        repeats:YES];
    
}

- (BOOL)isCentroDelVillaggioCostruito
{
    
    return self.delegate.timeLeftToBuildCentroDelVillaggio <= 0;
    
}

- (BOOL)isCasermaCostruita
{
    
    return self.delegate.timeLeftToBuildCaserma <= 0;
    
}

- (BOOL)buttonToBuildCentroDelVillaggioExists
{
    
    return self.aButton != nil;
    
}

- (BOOL)buttonToBuildCasermaExists
{
    
    return self.aButtonToBuildCaserma != nil;
    
}

- (void)removeButtonForBuildCentroDelVillaggio
{
    
    [self.aButton removeFromSuperview];
    self.aButton = nil;
    
}

- (void)removeButtonForBuildCaserma
{
    
    [self.aButtonToBuildCaserma removeFromSuperview];
    self.aButtonToBuildCaserma = nil;
    
}

- (void)showLabelCentroDelVillaggioInCostruzione
{
    
    [self.view addSubview:self.labelInContruzione];
    
}

- (void)showLabelCasermaInCostruzione
{
    
    [self.view addSubview:self.labelCasermaInContruzione];
    
}

- (void)mostraBottonePerCostruireIlCentroDelVillaggio
{
    
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButton setFrame:CGRectMake(20,360,280,40)];
    [self.aButton setTitle:@"Centro del Villaggio" forState:UIControlStateNormal];
    [self.aButton addTarget:self action:@selector(costruisciCentroDelVillaggio) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButton];
    
}

- (void)mostraBottonePerCostruireLaCaserma
{

    self.aButtonToBuildCaserma = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButtonToBuildCaserma setFrame:CGRectMake(20,360,280,40)];
    [self.aButtonToBuildCaserma setTitle:@"Caserma" forState:UIControlStateNormal];
    [self.aButtonToBuildCaserma addTarget:self action:@selector(costruisciCaserma) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButtonToBuildCaserma];
    
}

- (BOOL)centroDelVillaggionNotExists
{
    
    return self.delegate.booCentroDelVillaggio == 0;
    
}

- (BOOL)centroDelVillaggionExists
{
    
    return ![self centroDelVillaggionNotExists];
    
}

- (BOOL)possoCostruireLaCaserma
{
    
    return
    [self centroDelVillaggionExists] &&
    [self isCentroDelVillaggioCostruito];
    
}

@end
