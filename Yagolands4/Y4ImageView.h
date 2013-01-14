#import <UIKit/UIKit.h>

@interface Y4ImageView : UIImageView

@property (nonatomic) NSInteger tag;
@property (nonatomic) NSInteger numeroTappate;

- (void)incrementaTappate;
- (void)toggleImage;

@end