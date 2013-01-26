#import <UIKit/UIKit.h>

@interface Y4AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

@property (nonatomic) BOOL booCentroDelVillaggio;
@property (nonatomic) NSDate * endJobCentroDelVillaggio;
@property (nonatomic) NSInteger idCentroDelVillaggio;

- (float)timeLeftToBuildCentroDelVillaggio;

@end
