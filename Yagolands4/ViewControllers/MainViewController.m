#import "MainViewController.h"
#import "CellViewController.h"
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
        [self setTitle:@"Yagolands"];
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.delegate.idCentroDelVillaggio > 0) {
        NSInteger tag = self.delegate.idCentroDelVillaggio;
        [(Y4ImageView *)[self.view viewWithTag:tag] setImageOfCentroDelVillaggio];
    }
    
    if(self.delegate.idCaserma > 0) {
        NSInteger tag = self.delegate.idCaserma;
        [(Y4ImageView *)[self.view viewWithTag:tag] setImageOfCaserma];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
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
    [self setPosizioneY:140];
    [self disegnaTerreniCon:centro];
}

- (void)disegnaLeTerreNemicheCon: (Y4Coordinata *)centro
{
    [self setPosizioneX:200];
    [self setPosizioneY:300];
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
    [imageView setFrame:CGRectMake([self posizioneX]+offsetSinistro,self.posizioneY+offsetAlto,larghezzaCella,larghezzaCella)];
    [imageView setUserInteractionEnabled:TRUE];
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleImage:)]];
    [self.view addSubview:imageView];
}

- (void)toggleImage: (id)sender
{
    /* Recupero la view da caricare */
    Y4ImageView * view = (Y4ImageView *)((UITapGestureRecognizer *)sender).view;
    
    if(view.tag != self.delegate.idCentroDelVillaggio &&
       view.tag != self.delegate.idCaserma) {
        /* Inversione dell'immagine. */
        [view toggleImage];
        /* Carico il ViewController della cella. */
        CellViewController * cell = nil;
        cell = [[CellViewController alloc] init];
        [cell setIdCell:view.tag];
        [self.navigationController pushViewController:cell animated:TRUE];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"ATTENZIONE!!"
                                                         message:@"Cella già occupata"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
