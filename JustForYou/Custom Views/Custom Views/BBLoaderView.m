#import "BBLoaderView.h"

@implementation BBLoaderView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self createSelfFromNib];
  }
  return self;
}

- (void)createSelfFromNib {
  NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBLoaderView" owner:self options:nil];
  UIView *mainView = [subviewArray objectAtIndex:0];
  [self addSubview:mainView];
  self.contentView.frame = self.bounds;
}

@end
