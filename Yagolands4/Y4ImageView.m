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

    /* Chiamata GET al server. */
    NSURL * url = [NSURL URLWithString:@"http://localhost:8888/cella.php"];
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:&err];

    /*
     1xx - Informational responses,
     2xx - success
     3xx - Redirection
     4xx - Client error
     5xx - Server error
     */
}

@end
