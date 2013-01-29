#import "CellViewController.h"
#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [self mostraTestiDescrittivi];
    [self mostroAzioniDisponibili];
    
    [self setTitle:@"Landa desolata"];
    [((UITextView *)[self.view viewWithTag:102]) setText:@"Luogo sconosciuto."];
    [((UITextView *)[self.view viewWithTag:103]) setText:@"Descrizione sconosciuta."];
    
    if(self.delegate.idCentroDelVillaggio && (self.delegate.idCentroDelVillaggio) == self.idCell) {
        [self setTitle:@"Centro del Villaggio"];
        [((UITextView *)[self.view viewWithTag:102]) setText:@"Centro Del Villaggio"];
        [((UITextView *)[self.view viewWithTag:103]) setText:@"Questa ora è casa tua."];
    }
    
    if(self.delegate.idCaserma && (self.delegate.idCaserma) == self.idCell) {
        [self setTitle:@"Caserma"];
        [((UITextView *)[self.view viewWithTag:102]) setText:@"Caserma"];
        [((UITextView *)[self.view viewWithTag:103]) setText:@"Addestra le tue truppe."];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    if([self centroDelVillaggionNotExists]) {
        [self mostraBottonePerCostruireIlCentroDelVillaggio];
    } else {
        if([self buttonToBuildCentroDelVillaggioExists]) {
            [self removeButtonForBuildCentroDelVillaggio];
            [self showLabelCentroDelVillaggioInCostruzione];
        }
    }
    
    if([self isCentroDelVillaggioCostruito]) {
        if ([self possoCostruireLaCaserma]) {
            [self mostraBottonePerCostruireLaCaserma];
        }
    } else {
        if([self buttonToBuildCasermaExists]) {
            [self removeButtonForBuildCaserma];
            [self showLabelCasermaInCostruzione];
        }
    }
    
    /* } else if ([self possoCostruireLaCaserma]) {
     [self mostraBottonePerCostruireLaCaserma]; */
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
    [self startTimerToBuildCaserma];
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    self.delegate.idCaserma = !self.delegate.idCaserma ? self.idCell : 0;
    [self.navigationController pushViewController:controller animated:true];
}

- (void)threadCostruisciCaserma:(NSTimer *)theTimer {
    if(self.delegate.idCaserma != 0 && [self isCasermaCostruita]) {
        NSLog(@"Ho terminato di costruire la Caserma.");
        [theTimer invalidate];
        theTimer = nil;
    } else {
        NSLog(@"Caserma costruita in %d.", (int)self.delegate.timeLeftToBuildCaserma);
        UILabel * label = (UILabel *)[self.view viewWithTag:101];
        [label setText:[NSString stringWithFormat:@"Tempo residuo %d", (int)self.delegate.timeLeftToBuildCaserma]];
    }
}

- (void)threadCostruisciCentroDelVillaggio:(NSTimer *)theTimer {
    if(self.delegate.idCentroDelVillaggio != 0 &&  [self isCentroDelVillaggioCostruito]) {
        NSLog(@"Ho terminato di costruire il Centro del Villaggio.");
        [theTimer invalidate];
        theTimer = nil;
    } else {
        NSLog(@"Centro del villaggio costruito in %d.", (int)self.delegate.timeLeftToBuildCentroDelVillaggio);
        UILabel * label = (UILabel *)[self.view viewWithTag:101];
        [label setText:[NSString stringWithFormat:@"Tempo residuo %d", (int)self.delegate.timeLeftToBuildCentroDelVillaggio]];
    }
}

- (void)showLabelPuoiCostruire
{
    NSLog(@"Mostro la label che dice che puoi costruire.");
    UILabel * labelCostruzioni = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 280, 40)];
    [labelCostruzioni setTextAlignment:NSTextAlignmentLeft];
    [labelCostruzioni setText:@"Che cosa puoi costruire:"];
    [self.view addSubview:labelCostruzioni];
}

- (void)startTimerToBuildCentroDelVillaggio
{
    NSLog(@"startTimerToBuildCentroDelVillaggio");
    self.timerCentroDelVillaggio = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(threadCostruisciCentroDelVillaggio:)
                                                                  userInfo:nil
                                                                   repeats:YES];
}

- (void)startTimerToBuildCaserma
{
    NSLog(@"startTimerToBuildCaserma");
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
    self.labelInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
    [self.labelInContruzione setTextAlignment:NSTextAlignmentLeft];
    [self.labelInContruzione setTag:101];
    [self.view addSubview:self.labelInContruzione];
}

- (void)showLabelCasermaInCostruzione
{
    self.labelCasermaInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
    [self.labelCasermaInContruzione setTextAlignment:NSTextAlignmentLeft];
    [self.labelCasermaInContruzione setTag:101];
    [self.view addSubview:self.labelCasermaInContruzione];
}

- (void)mostraBottonePerCostruireIlCentroDelVillaggio
{
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButton setFrame:CGRectMake(20,360,280,40)];
    [self.aButton setTitle:@"Centro del Villaggio"
                  forState:UIControlStateNormal];
    [self.aButton addTarget:self
                     action:@selector(costruisciCentroDelVillaggio)
           forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButton];
}

- (void)mostraBottonePerCostruireLaCaserma
{
    self.aButtonToBuildCaserma = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButtonToBuildCaserma setFrame:CGRectMake(20,360,280,40)];
    [self.aButtonToBuildCaserma setTitle:@"Caserma"
                  forState:UIControlStateNormal];
    [self.aButtonToBuildCaserma addTarget:self
                     action:@selector(costruisciCaserma)
           forControlEvents:UIControlEventTouchDown]; // */
    [self.view addSubview:self.aButtonToBuildCaserma];
}

- (BOOL)centroDelVillaggionNotExists
{
    BOOL centroDelVillaggioNotExists = self.delegate.booCentroDelVillaggio == 0;
    if(centroDelVillaggioNotExists == YES) {
        NSLog(@"Il centro del villaggio non esiste.");
    } else {
        NSLog(@"Il centro del villaggio esiste.");
    }
    return centroDelVillaggioNotExists;
}

- (BOOL)centroDelVillaggionExists
{
    return ![self centroDelVillaggionNotExists];
}

- (BOOL)templioNotExists
{
    return YES;
}

- (BOOL)possoCostruireLaCaserma
{
    return [self centroDelVillaggionExists] && [self isCentroDelVillaggioCostruito] && [self templioNotExists];
}

@end
