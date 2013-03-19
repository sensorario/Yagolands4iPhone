#import <Foundation/Foundation.h>

@interface Y4Coordinata : NSObject

@property (nonatomic) NSInteger coordX;
@property (nonatomic) NSInteger coordY;

- (void)moveRight;
- (void)moveLeft;
- (void)moveLeftUp;
- (void)moveLeftDown;
- (void)moveRightDown;
- (void)moveRightUp;
- (void)moveCenter;

- (NSInteger)getX;
- (NSInteger)getY;

@end
