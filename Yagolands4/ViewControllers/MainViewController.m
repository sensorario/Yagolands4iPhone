    //
    //  MainViewController.m
    //  Yagolands4
    //
    //  Created by Simone Gentili on 12/01/13.
    //  Copyright (c) 2013 SENSORARIO. All rights reserved.
    //

#import "MainViewController.h"
#import "Y4Coordinata.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize posizioneX;
@synthesize posizioneY;

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
    [self setPosizioneX:0];
    [self setPosizioneY:180];
    [self disegnaTerreniCon:centro];
}

- (void)disegnaLeTerreNemicheCon: (Y4Coordinata *)centro
{
    [self setPosizioneX:320];
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
    [centro moveRight];
    [self aggiungiCellaIn:centro];
    [centro moveRightUp];
    [self aggiungiCellaIn:centro];
    [centro moveLeftUp];
    [self aggiungiCellaIn:centro];
    [centro moveLeft];
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
    UIImageView * imageView = [[UIImageView alloc] init];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(imageTapped)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = TRUE;
    
    [imageView setImage:[UIImage imageNamed:@"cella.png"]];
    [imageView setFrame:CGRectMake([self posizioneX] + offsetSinistro, [self posizioneY] + offsetAlto, larghezzaCella, larghezzaCella)];
    [self.view addSubview:imageView];
}

- (void)imageTapped
{
    NSLog(@"imageTapped");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
