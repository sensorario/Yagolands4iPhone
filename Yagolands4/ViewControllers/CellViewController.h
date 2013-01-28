#import <UIKit/UIKit.h>
#import "Y4AppDelegate.h"

@interface CellViewController : UIViewController

@property (nonatomic) int idCell;
@property (nonatomic) NSString * building;
@property (nonatomic) UIButton * aButton;
@property (nonatomic) UILabel * labelInContruzione;
@property (nonatomic, strong) Y4AppDelegate * delegate;
@property (nonatomic) NSTimer * timer;

@end
