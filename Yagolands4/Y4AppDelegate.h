#import <UIKit/UIKit.h>

@interface Y4AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

/* Centro del Villaggio */
@property (nonatomic) BOOL booCentroDelVillaggio;
@property (nonatomic) NSDate * endJobCentroDelVillaggio;
@property (nonatomic) NSInteger idCentroDelVillaggio;

/* Caserma */
@property (nonatomic) NSInteger idCaserma;

- (float)timeLeftToBuildCentroDelVillaggio;

@end
