#import <UIKit/UIKit.h>
#import "Y4Coordinata.h"
#import "Y4AppDelegate.h"

@interface MainViewController : UIViewController

@property (nonatomic) NSInteger posizioneX;
@property (nonatomic) NSInteger posizioneY;
@property (nonatomic) NSInteger identificatoreCella;
@property (nonatomic, strong) Y4AppDelegate * delegate;

@end
