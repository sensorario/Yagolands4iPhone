#import <UIKit/UIKit.h>
#import "Y4Coordinata.h"
#import "Yagolands4ViewController.h"

@interface MainViewController : Yagolands4ViewController

/* Posizione del giocatore. */
@property (nonatomic) NSInteger posizioneX;
@property (nonatomic) NSInteger posizioneY;

/* Cella corrente. */
@property (nonatomic) NSInteger identificatoreCella;

@end
