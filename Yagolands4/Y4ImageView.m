#import "Y4ImageView.h"

@implementation Y4ImageView {
    NSString * immaginePerIClickPari;
    NSString * immaginePerIClickDispari;
    NSString * immagineCentroDelVillaggio;
    NSString * immagineCaserma;
}

@synthesize numeroTappate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        immaginePerIClickPari = @"cella.png";
        immaginePerIClickDispari = @"cella-cliccata.png";
        immagineCentroDelVillaggio = @"centro_del_villaggio.png";
        immagineCaserma = @"caserma.png";
        [self setImage:[UIImage imageNamed:immaginePerIClickPari]];
    }
    return self;
}

- (void)toggleImage
{
    /* Gestisco il cambio dell'immagine. */
    NSString * immagine = self.numeroTappate%2==0?immaginePerIClickDispari:immaginePerIClickPari;
    [self setImage:[UIImage imageNamed:immagine]];
    ++self.numeroTappate;
    
    /* Chiamata GET al server. */ /*
    NSURL * url = [NSURL URLWithString:@"http://localhost:8888/cella.php"];
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err]; */
}

- (void)setImageOfCentroDelVillaggio
{
    UIImage * nomeImmagine = [UIImage imageNamed:immagineCentroDelVillaggio];
    [self setImage:nomeImmagine];
}

- (void)setImageOfCaserma
{
    UIImage * nomeImmagine = [UIImage imageNamed:immagineCaserma];
    [self setImage:nomeImmagine];
}

@end
