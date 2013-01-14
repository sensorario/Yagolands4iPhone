#import "Y4ImageView.h"

@implementation Y4ImageView {
    NSString * pari;
    NSString * dispari;
}

@synthesize tag;
@synthesize numeroTappate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pari = @"cella.png";
        dispari = @"cella-cliccata.png";
        [self setImage:[UIImage imageNamed:pari]];
    }
    return self;
}

- (void)toggleImage
{
    NSString * immagine = self.numeroTappate%2==0?dispari:pari;
    [self setImage:[UIImage imageNamed:immagine]];    
    ++self.numeroTappate;
}

@end
