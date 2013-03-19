#import "Y4AppDelegate.h"
#import "MainViewController.h"
#import "Y4EndGameViewController.h"
#import "Y4GameOverViewController.h"

@implementation Y4AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /* Inizializzo l'applicazione. */
    [self setBooCentroDelVillaggio:false];
    [self setGiocoFinito:NO];
    [self setEdificioInCostruzione:NO];
    [self setIdEdificioCorrente:nil];
    [self setHoChiusoLaFinestra:NO];
    [self setNumeroInterazioni:0];

    /* Definisco il mio rootViewController. */
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

# pragma mark - Getter del tempo

- (float)timeLeftToBuildCentroDelVillaggio
{
    
    NSDate * now = [[NSDate alloc] init];
    return [self.endJobCentroDelVillaggio timeIntervalSinceDate:now];
    
}

- (float)timeLeftToBuildCaserma
{
    
    NSDate * now = [[NSDate alloc] init];
    return [self.endJobCaserma timeIntervalSinceDate:now];
    
}

# pragma mark - Fine gioco

- (void)endGame
{
    
    Y4EndGameViewController * controller = [[Y4EndGameViewController alloc] init];
    self.window.rootViewController = controller;
    
}

- (void)gameOver
{
    
    Y4GameOverViewController * controller = [[Y4GameOverViewController alloc] init];
    self.window.rootViewController = controller;
    
}

@end
