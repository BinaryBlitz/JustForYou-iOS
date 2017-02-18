#import "BBImageWithLoader.h"

@implementation BBImageWithLoader

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initLoaderView];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self initLoaderView];
  }
  return self;
}

- (void)initLoaderView {
  self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  self.indicatorView.color = [BBConstantAndColor applicationOrangeColor];
  [self addSubview:self.indicatorView];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)awakeFromNib {
  [super awakeFromNib];
  self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end
