#import <UIKit/UIKit.h>

@interface Y4AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

/* Variabili di gioco. */
@property (nonatomic) BOOL giocoFinito;
@property (nonatomic) BOOL edificioInCostruzione;
@property (nonatomic) NSInteger idEdificioCorrente;

/* Centro del Villaggio. */
@property (nonatomic) BOOL booCentroDelVillaggio;
@property (nonatomic) NSDate * endJobCentroDelVillaggio;
@property (nonatomic) NSInteger idCentroDelVillaggio;

/* Caserma. */
@property (nonatomic) BOOL booCaserma;
@property (nonatomic) NSInteger idCaserma;
@property (nonatomic) NSDate * endJobCaserma;

/* Controlli generali. */
@property (nonatomic) BOOL hoChiusoLaFinestra;

/* Metodi. */
- (float)timeLeftToBuildCentroDelVillaggio;
- (float)timeLeftToBuildCaserma;

@end
