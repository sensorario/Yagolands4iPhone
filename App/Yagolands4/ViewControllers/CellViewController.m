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
    
    /* Richiamo il costruttore per avere il delegate. */
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
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
    
    if([self.delegate giocoFinito]==NO) {
    
        /* Mostro l'interfaccia. */
        [self mostraTestiDescrittivi];
        [self mostroAzioniDisponibili];
        
        /* Imposto i messaggi di default di una cella (landa desolata). */
        Y4LandaDesolata * landaDesolata = [[Y4LandaDesolata alloc] init];
        [self setTitle:[landaDesolata getName]];
        [((UITextView *)[self.view viewWithTag:102]) setText:[landaDesolata getLocation]];
        [((UITextView *)[self.view viewWithTag:103]) setText:[landaDesolata getDescription]];
        
        /* Se mi trovo nel centro del villaggio sostituisco i testi. */
        if(self.delegate.idCentroDelVillaggio && (self.delegate.idCentroDelVillaggio) == self.idCell) {
            Y4CentroDelVillaggio * centro = [[Y4CentroDelVillaggio alloc] init];
            [self setTitle:[centro getName]];
            [((UITextView *)[self.view viewWithTag:102]) setText:[centro getLocation]];
            [((UITextView *)[self.view viewWithTag:103]) setText:[centro getDescription]];
        }
        
        /* Se mi trovo nella caserma sostituisco i testi. */
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
    
    /* Mostro la label che indica gli edifici in costruzione. */
    self.labelInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
    [self.labelInContruzione setTextAlignment:NSTextAlignmentLeft];
    [self.labelInContruzione setTag:101];
    
}

- (void)mostraTestiDescrittivi
{
    
    /* Disegno le label del ViewController. */
    [self showLabeldLandaDesolata];
    [self showDescrizioneLandaDesolata];
    
}

- (void)mostroAzioniDisponibili
{
    
    [self showLabelPuoiCostruire];
    
    /* Mostro il bottone del centro del villaggio. */
    if([self centroDelVillaggionNotExists]) {
        [self mostraBottonePerCostruireIlCentroDelVillaggio];
    }
    
    /* Rimuovo bottoni se è in costruzione */
    if((int)self.delegate.timeLeftToBuildCentroDelVillaggio > 0) {
        [self removeButtonForBuildCentroDelVillaggio];
        [self showLabelCentroDelVillaggioInCostruzione];
    }
    
    /* Mostro il bottone della caserma. */
    if([self centroDelVillaggionExists] && [self isCentroDelVillaggioCostruito]) {
        if(!(self.delegate.idCaserma > 0)) {
            [self mostraBottonePerCostruireLaCaserma];
        }
    }
    
    /* Rimuovo bottoni se è in costruzione */
    if ((int)self.delegate.timeLeftToBuildCaserma > 0) {
        [self removeButtonForBuildCaserma];
        [self showLabelCasermaInCostruzione];
    }
    
}

- (void)threadSfidante
{
    
    /* Da quanti secondi è stato attivato il bot. */
    self.delegate.numeroInterazioni = (int)self.delegate.numeroInterazioni + 1;
    NSLog(@"Iterazione numero %d", (int)self.delegate.numeroInterazioni);
    
    /* Il gioco termina allo scadere dei 20 secondi. */
    if((int)self.delegate.numeroInterazioni == 20) {
        [self.timerSfidante invalidate];
        [self.delegate gameOver];
    }
    
}

# pragma mark Utility methods

- (void)showDescrizioneLandaDesolata
{
    
    /* Mostro la descrizione di questa cella. */
    UILabel * labelDescrizione = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
    [labelDescrizione setNumberOfLines:4];
    [labelDescrizione setTextAlignment:NSTextAlignmentCenter];
    [labelDescrizione setText:@"Questa è una landa desolata, un luogo edificabile in cui è possibile fondare il proprio villaggio."];
    [labelDescrizione setTag:103];
    [self.view addSubview:labelDescrizione];
    
}

- (void)showLabeldLandaDesolata
{
    
    /* Mostro il titolo di questa cella. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Landa Desolata"];
    [label setTag:102];
    [self.view addSubview:label];
    
}

- (void)costruisciCentroDelVillaggio
{
    
    /* Faccio partire il thread del bot. */
    self.timerSfidante = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(threadSfidante)
                                                        userInfo:nil
                                                         repeats:YES];
    
    /* Inizio a costruire il centro del villaggio. */
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
        
        [self.delegate endGame];
        
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
 
    /* Faccio partire il thread di costruzione del centro del villaggio. */
    self.timerCentroDelVillaggio = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(threadCostruisciCentroDelVillaggio:)
                                                                  userInfo:nil
                                                                   repeats:YES];
    
}

- (void)startTimerToBuildCaserma
{
    
    /* Faccio partire il thread di costruzione della caserma. */
    self.timerCaserma = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(threadCostruisciCaserma:)
                                                       userInfo:nil
                                                        repeats:YES];
    
}

- (BOOL)isCentroDelVillaggioCostruito
{
    
    /* Se il tempo di costruzione è <= 0, allora l'edificio è stato già costruito. */
    return self.delegate.timeLeftToBuildCentroDelVillaggio <= 0;
    
}

- (BOOL)isCasermaCostruita
{
    
    /* Se il tempo rimasto è minore o uguale a zero, allora è stato costruito. */
    return self.delegate.timeLeftToBuildCaserma <= 0;
    
}

- (BOOL)buttonToBuildCentroDelVillaggioExists
{
    
    /* Mi dice se il bottone esiste o meno. */
    return self.aButton != nil;
    
}

- (BOOL)buttonToBuildCasermaExists
{
    
    /* Mi dice se il bottone esiste o meno. */
    return self.aButtonToBuildCaserma != nil;
    
}

- (void)removeButtonForBuildCentroDelVillaggio
{
    
    /* Rimuove il bottone dalla sua superview. */
    [self.aButton removeFromSuperview];
    self.aButton = nil;
    
}

- (void)removeButtonForBuildCaserma
{
    
    /* Rimuove il bottone dalla sua superview. */
    [self.aButtonToBuildCaserma removeFromSuperview];
    self.aButtonToBuildCaserma = nil;
    
}

- (void)showLabelCentroDelVillaggioInCostruzione
{
    
    /* Mostro la label del centro del villeggio che è in costruzione. */
    [self.view addSubview:self.labelInContruzione];
    
}

- (void)showLabelCasermaInCostruzione
{
    
    /* Motro la label della caserma che è in cotruzione. */
    [self.view addSubview:self.labelCasermaInContruzione];
    
}

- (void)mostraBottonePerCostruireIlCentroDelVillaggio
{
    
    /* Mostro il bottone per costuire il centro del villaggio */
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButton setFrame:CGRectMake(20,360,280,40)];
    [self.aButton setTitle:@"Centro del Villaggio" forState:UIControlStateNormal];
    [self.aButton addTarget:self action:@selector(costruisciCentroDelVillaggio) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButton];
    
}

- (void)mostraBottonePerCostruireLaCaserma
{

    /* Mostro il bottone per costruire la caserma. */
    self.aButtonToBuildCaserma = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButtonToBuildCaserma setFrame:CGRectMake(20,360,280,40)];
    [self.aButtonToBuildCaserma setTitle:@"Caserma" forState:UIControlStateNormal];
    [self.aButtonToBuildCaserma addTarget:self action:@selector(costruisciCaserma) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButtonToBuildCaserma];
    
}

- (BOOL)centroDelVillaggionNotExists
{
 
    /* Dico se il centro del villaggio esiste o meno. */
    return self.delegate.booCentroDelVillaggio == 0;
    
}

- (BOOL)centroDelVillaggionExists
{
    
    /* Mostro se il centro del villaggio esiste o meno. */
    return ![self centroDelVillaggionNotExists];
    
}

- (BOOL)possoCostruireLaCaserma
{
    
    /* Posso o meno costruire la caserma? */
    return [self centroDelVillaggionExists] && [self isCentroDelVillaggioCostruito];
    
}

@end
