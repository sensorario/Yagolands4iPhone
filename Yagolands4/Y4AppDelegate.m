#import "Y4AppDelegate.h"
#import "MainViewController.h"

@implementation Y4AppDelegate

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /* Inizializzo l'app. */
    [self setBooCentroDelVillaggio:false];
    [self setGiocoFinito:NO];
    [self setEdificioInCostruzione:NO];
    [self setIdEdificioCorrente:nil];
    [self setHoChiusoLaFinestra:NO];

    /* Definisco il mio rootViewController. */
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
