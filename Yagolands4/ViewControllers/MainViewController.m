#import "MainViewController.h"
#import "Y4ImageView.h"
#import "Y4Coordinata.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize posizioneX;
@synthesize posizioneY;
@synthesize identificatoreCella;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Hai caricato il MainViewController");
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 440, 40)];
    [label setText:@"Wellcome to Yagolands4iPhone"];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    Y4Coordinata * coordinata = [[Y4Coordinata alloc] init];
    [self disegnaLeMieTerreCon:coordinata];
    [self disegnaLeTerreNemicheCon:coordinata];
}

- (void)disegnaLeMieTerreCon: (Y4Coordinata *)centro
{
    [self setPosizioneX:40];
    [self setPosizioneY:180];
    [self disegnaTerreniCon:centro];
}

- (void)disegnaLeTerreNemicheCon: (Y4Coordinata *)centro
{
    [self setPosizioneX:340];
    [self setPosizioneY:120];
    [self disegnaTerreniCon:centro];
}

- (void)disegnaTerreniCon: (Y4Coordinata *)centro
{
    [centro moveCenter];
    [self aggiungiCellaIn:centro];
    [centro moveRight];
    [self aggiungiCellaIn:centro];
    [centro moveLeftDown];
    [self aggiungiCellaIn:centro];
    [centro moveLeft];
    [self aggiungiCellaIn:centro];
    [centro moveLeftUp];
    [self aggiungiCellaIn:centro];
    [centro moveRightUp];
    [self aggiungiCellaIn:centro];
    [centro moveRight];
    [self aggiungiCellaIn:centro];
}

- (void)aggiungiCellaIn: (Y4Coordinata *)coordinata
{
    /* Dimenzioni della cella. */
    int larghezzaCella = 40;
    int altezzaCella = larghezzaCella * 3 / 4;
    
    /* Ricalcolo degli offset. */
    int offsetSinistro = [coordinata getX] * larghezzaCella;
    int offsetAlto = ([coordinata getY] * altezzaCella);
    
    /* Spostamento laterale. delle coordinate pari. */
    if ([coordinata getY] % 2 == 0) {
        offsetSinistro = offsetSinistro + (larghezzaCella / 2);
    }
    
    /* Disegno dell'immagine. */
    Y4ImageView * imageView = [[Y4ImageView alloc] init];
    [imageView setTag:++identificatoreCella];
    [imageView setFrame:CGRectMake([self posizioneX] + offsetSinistro, [self posizioneY] + offsetAlto, larghezzaCella, larghezzaCella)];
    [imageView setUserInteractionEnabled:TRUE];
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleImage:)]];
    [self.view addSubview:imageView];
}

- (void)toggleImage: (id)sender
{
    UITapGestureRecognizer * gesture = (UITapGestureRecognizer *)sender;
    Y4ImageView * imageView = (Y4ImageView *)gesture.view;
    
    [imageView toggleImage];
    [imageView incrementaTappate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
