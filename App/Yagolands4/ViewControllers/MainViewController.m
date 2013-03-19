#import "MainViewController.h"
#import "CellViewController.h"
#import "Y4ImageView.h"
#import "Y4Coordinata.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    /* Richiamo il costruttore per avere il delegate. */
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
 
    /* Imposto il titolo della schermata. */
    [self setTitle:@"Yagolands"];
    
    /* Se in questa mappa c'è il centro del villaggio, lo mostro. */
    if(self.delegate.idCentroDelVillaggio > 0) {
        NSInteger tag = self.delegate.idCentroDelVillaggio;
        [(Y4ImageView *)[self.view viewWithTag:tag] setImageOfCentroDelVillaggio];
    }
    
    /* Se in questa mappa c'è la caserma, la mostro. */
    if(self.delegate.idCaserma > 0) {
        NSInteger tag = self.delegate.idCaserma;
        [(Y4ImageView *)[self.view viewWithTag:tag] setImageOfCaserma];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    /* Se sto costruendo un edificio. */
    if(self.delegate.edificioInCostruzione == YES) {
        
        /* Mostro un messaggio di errore. */
        [[[UIAlertView alloc] initWithTitle:@"MAPPA NON VISIBILE"
                                    message:@"Non puoi vedere la mappa mentre viene costruito un edificio."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil] show];
        
        /* ... e mostro di nuovo l'edificio corrente. */
        CellViewController * cell = nil;
        cell = [[CellViewController alloc] init];
        [cell setIdCell:self.delegate.idEdificioCorrente];
        [self.navigationController pushViewController:cell animated:TRUE];
        
    }
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    /* Mostro un messaggio di benvenuto. */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [label setText:@"Wellcome to Yagolands4iPhone"];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    /* Disegno le due plance di gioco. */
    Y4Coordinata * coordinata = [[Y4Coordinata alloc] init];
    [self disegnaLeMieTerreCon:coordinata];
    [self disegnaLeTerreNemicheCon:coordinata];
    
}

- (void)disegnaLeMieTerreCon: (Y4Coordinata *)centro
{
    
    /* Imposto il centro per le celle del giocaoter umano */
    [self setPosizioneX:40];
    [self setPosizioneY:140];
    
    /* Disegno le celle attorno a quel centro. */
    [self disegnaTerreniCon:centro];
    
}

- (void)disegnaLeTerreNemicheCon: (Y4Coordinata *)centro
{
    
    /* Imposto il centro per le celle del computer. */
    [self setPosizioneX:200];
    [self setPosizioneY:300];
    
    /* Disegno le celle attorno a quel centro. */
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
    [imageView setTag:++self.identificatoreCella];
    [imageView setFrame:CGRectMake([self posizioneX]+offsetSinistro,self.posizioneY+offsetAlto,larghezzaCella,larghezzaCella)];
    [imageView setUserInteractionEnabled:TRUE];
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleImage:)]];
    [self.view addSubview:imageView];
    
}

- (void)toggleImage: (id)sender
{
    
    /* Recupero la view da caricare */
    Y4ImageView * view = (Y4ImageView *)((UITapGestureRecognizer *)sender).view;
    
    /* Se la cella appartiene alla plancia di sotto. */
    if(view.tag > 7) {
        
        /* Avverto l'utente che quelle celle sono riservate. */
        [[[UIAlertView alloc] initWithTitle:@"IMPOSSIBILE COSTRUIRE"
                                    message:@"Tu puoi costruire solo nelle celle di sopra."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil] show];
        
    } else {
        
        /* Se la cella è libera. */
        if(view.tag != self.delegate.idCentroDelVillaggio &&
           view.tag != self.delegate.idCaserma) {
            
            /* Entro nel dettaglio di quella cella. */
            [view toggleImage];
            CellViewController * cell = nil;
            cell = [[CellViewController alloc] init];
            [cell setIdCell:view.tag];
            [self.navigationController pushViewController:cell animated:TRUE];
            
        } else {
            
            /* Altrimentio avverto l'utente che la cella è occupata da un altro edificio. */
            [[[UIAlertView alloc] initWithTitle:@"ATTENZIONE!!"
                                        message:@"Cella già occupata"
                                       delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil] show];
            
        }
        
    }
    
}

@end
