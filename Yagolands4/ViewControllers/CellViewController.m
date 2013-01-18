
#import "CellViewController.h"
#import "StartToBuildViewController.h"

@interface CellViewController ()

@end

@implementation CellViewController

- (void)setIdCell:(int)idCell
{
    [self setTitle:@"Landa desolata"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Cella"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mostraTestiDescrittivi];
    [self mostroAzioniDisponibili];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchDown
{
    StartToBuildViewController * controller = [[StartToBuildViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

- (void)mostraTestiDescrittivi
{
    /* Mostro la label di questa cella. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Landa Desolata"];
    [self.view addSubview:label];
    
    /* Descrizione della cella in cui si trova l'utente */
    UILabel * labelDescrizione = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
    [labelDescrizione setNumberOfLines:4];
    [labelDescrizione setTextAlignment:NSTextAlignmentCenter];
    [labelDescrizione setText:@"Questa è una landa desolata, un luogo edificabile in cui è possibile fondare il proprio villaggio."];
    [self.view addSubview:labelDescrizione];
}

- (void)mostroAzioniDisponibili
{
    /* Mostro la label di questa cella. */
    UILabel * labelCostruzioni = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 280, 40)];
    [labelCostruzioni setTextAlignment:NSTextAlignmentLeft];
    [labelCostruzioni setText:@"Che cosa puoi costruire:"];
    [self.view addSubview:labelCostruzioni];
    
    /* Mostro il bottone per costruire il centro del villaggio. */
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    aButton.frame = CGRectMake(20,360,280,40);
    [aButton setTitle:@"Centro del Villaggio" forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:aButton];
}

@end
