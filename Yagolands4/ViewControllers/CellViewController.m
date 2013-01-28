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
    
    if(self.delegate.idCentroDelVillaggio && (self.delegate.idCentroDelVillaggio) == self.idCell) {
        [self setTitle:@"Centro del Villaggio"];
    } else {
        [self setTitle:@"Landa desolata"];
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
    } else if ([self possoCostruireLaCaserma]) {
        [self mostraBottonePerCostruireLaCaserma];
    } else {
        if([self buttonExists]) {
            [self removeButton];
            [self showLabelInCostruzione];
            [self startTimer];
        }
    }    
}

# pragma mark Utility methods

- (void)showDescrizioneLandaDesolata
{
    UILabel * labelDescrizione = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
    [labelDescrizione setNumberOfLines:4];
    [labelDescrizione setTextAlignment:NSTextAlignmentCenter];
    [labelDescrizione setText:@"Questa è una landa desolata, un luogo edificabile in cui è possibile fondare il proprio villaggio."];
    [self.view addSubview:labelDescrizione];
}

- (void)showLabeldLandaDesolata
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Landa Desolata"];
    [self.view addSubview:label];
}

- (void)costruisciCentroDelVillaggio
{
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    if(self.delegate.idCentroDelVillaggio == 0) {
        NSLog(@"Imposto l'id del Centro del Villaggio a %d.", self.idCell);
        self.delegate.idCentroDelVillaggio = self.idCell;
    } else {
        NSLog(@"Id Centro del Villaggio = %d.", self.delegate.idCentroDelVillaggio);
    }
    [self.navigationController pushViewController:controller animated:true];
}

- (void)costruisciCaserma
{
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    if(self.delegate.idCaserma == 0) {
        NSLog(@"Imposto l'id della cella con la Caserma a %d.", self.idCell);
        self.delegate.idCaserma = self.idCell;
    } else {
        NSLog(@"La Caserma ha id = %d.", self.delegate.idCaserma);
    }
    [self.navigationController pushViewController:controller animated:true];
}

- (void)threadCostruisciCentroDelVillaggio:(NSTimer *)theTimer {
    if([self isCentroDelVillaggioCostruito]) {
        NSLog(@"Ho terminato di costruire il centro del villaggio.");
        [self.timer invalidate];
        self.timer = nil;
    } else {
        NSLog(@"Centro del villaggio costruito in %d.", (int)self.delegate.timeLeftToBuildCentroDelVillaggio);
        UILabel * label = (UILabel *)[self.view viewWithTag:101];
        [label setText:[NSString stringWithFormat:@"Tempo residuo %d", (int)self.delegate.timeLeftToBuildCentroDelVillaggio]];
    }
}

- (void)showLabelPuoiCostruire
{
    UILabel * labelCostruzioni = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 280, 40)];
    [labelCostruzioni setTextAlignment:NSTextAlignmentLeft];
    [labelCostruzioni setText:@"Che cosa puoi costruire:"];
    [self.view addSubview:labelCostruzioni];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(threadCostruisciCentroDelVillaggio:)
                                           userInfo:nil
                                            repeats:YES];
}

- (BOOL)isCentroDelVillaggioCostruito
{
    return self.delegate.timeLeftToBuildCentroDelVillaggio <= 0;
}

- (BOOL)buttonExists
{
    return self.aButton != nil;
}

- (void)removeButton
{
    [self.aButton removeFromSuperview];
    self.aButton = nil;
}

- (void)showLabelInCostruzione
{
    self.labelInContruzione = [[UILabel alloc] initWithFrame:CGRectMake(20,360,280,40)];
    [self.labelInContruzione setTextAlignment:NSTextAlignmentLeft];
    [self.labelInContruzione setTag:101];
    [self.view addSubview:self.labelInContruzione];
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
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButton setFrame:CGRectMake(20,360,280,40)];
    [self.aButton setTitle:@"Caserma"
                  forState:UIControlStateNormal];
    [self.aButton addTarget:self
                     action:@selector(costruisciCaserma)
           forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButton];
}

- (BOOL)centroDelVillaggionNotExists
{
    return self.delegate.booCentroDelVillaggio == 0;
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
