#import <UIKit/UIKit.h>

#define SENSO_DEBUG
#ifdef SENSO_DEBUG
    #define SENSO_LOG(str) NSLog(@"%s", str)
#else
    #define SENSO_LOG(str)
#endif

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
