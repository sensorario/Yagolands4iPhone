#import "Yagolands4ViewController.h"

@interface Yagolands4ViewController ()

@end

@implementation Yagolands4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setDelegate:(Y4AppDelegate *)[[UIApplication sharedApplication] delegate]];
    }
    return self;
    
}

@end
