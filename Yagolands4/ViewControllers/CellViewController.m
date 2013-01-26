#import "CellViewController.h"
#import "StartToBuildViewController.h"
#import "Y4AppDelegate.h"

@interface CellViewController () {
    NSTimer * timer;
}

@property (nonatomic) NSTimer * timer;

@end

@implementation CellViewController

@synthesize timer;

- (void)setIdCell:(int)idCell
{    
    [self setTitle:@"Landa desolata"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Cella"];
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self mostraTestiDescrittivi];
    [self mostroAzioniDisponibili];
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
        [self showButton];
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

- (void)touchDown
{
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

- (void)targetMethod:(NSTimer *)theTimer {
    if([self isCentroDelVillaggioCostruito]) {
        [timer invalidate];
        timer = nil;
    } else {
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
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(targetMethod:)
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

- (void)showButton
{
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aButton setFrame:CGRectMake(20,360,280,40)];
    [self.aButton setTitle:@"Centro del Villaggio"
                  forState:UIControlStateNormal];
    [self.aButton addTarget:self
                     action:@selector(touchDown)
           forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.aButton];
}

- (BOOL)centroDelVillaggionNotExists
{
    return self.delegate.booCentroDelVillaggio == 0;
}

@end
