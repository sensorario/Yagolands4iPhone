#import <UIKit/UIKit.h>
#import "Yagolands4ViewController.h"

@interface CellViewController : Yagolands4ViewController

/* Miscellanea. */
@property (nonatomic) int idCell;
@property (nonatomic) NSString * building;

/* Label che indicano cosa si può costruire. */
@property (nonatomic) UILabel * labelInContruzione;
@property (nonatomic) UILabel * labelCasermaInContruzione;

/* Bottoni per costruire gli edifici. */
@property (nonatomic) UIButton * aButton;
@property (nonatomic) UIButton * aButtonToBuildCaserma;

/* Timer per gestire i thread. */
@property (nonatomic) NSTimer * timerCentroDelVillaggio;
@property (nonatomic) NSTimer * timerCaserma;
@property (nonatomic) NSTimer * timerCountdown;
@property (nonatomic) NSTimer * timerSfidante;

@end
