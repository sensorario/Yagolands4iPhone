#import "Y4Coordinata.h"

@implementation Y4Coordinata

@synthesize coordX;
@synthesize coordY;

- (id)init
{
    
    self = [super init];
    if (self) {
        [self moveCenter];
    }
    return self;
    
}

- (NSInteger)getX
{
    
    return coordX;
    
}

- (NSInteger)getY
{
    
    return coordY;
    
}

- (void)moveLeft
{
    
    coordX = coordX - 1;
    
}

- (void)moveLeftUp
{
    
    coordY = coordY + 1;
    
    if(coordY % 2 == 0) {
        [self moveLeft];
    }
    
}

- (void)moveLeftDown
{
    
    coordY = coordY - 1;
    
    if(coordY % 2 == 0) {
        [self moveLeft];
    }
    
}

- (void)moveRightDown
{
    
    if(coordY % 2 == 0) {
        [self moveRight];
    }
    
    coordY = coordY - 1;
    
}

- (void)moveRight
{
    
    coordX = coordX + 1;
    
}

- (void)moveRightUp
{
    
    if(coordY % 2 == 0) {
        [self moveRight];
    }
    
    coordY = coordY + 1;
    
}

- (void)moveCenter
{
    
    coordX = 0;
    coordY = 0;
    
}

@end
