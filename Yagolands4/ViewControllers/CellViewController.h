#import <UIKit/UIKit.h>
#import "Y4AppDelegate.h"

@interface CellViewController : UIViewController

@property (nonatomic) int idCell;
@property (nonatomic) NSString * building;
@property (nonatomic, strong) Y4AppDelegate * delegate;

@property (nonatomic) UILabel * labelInContruzione;
@property (nonatomic) UILabel * labelCasermaInContruzione;

@property (nonatomic) UIButton * aButton;
@property (nonatomic) UIButton * aButtonToBuildCaserma;

@property (nonatomic) NSTimer * timerCentroDelVillaggio;
@property (nonatomic) NSTimer * timerCaserma;
@property (nonatomic) NSTimer * timerCountdown;
@property (nonatomic) NSTimer * timerSfidante;

@end
