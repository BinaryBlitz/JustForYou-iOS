#import "BBButtonWithIndicator.h"

static CGFloat sizeLabel = 10.0f;
static CGFloat pointXLabel = 9.0f;
static CGFloat pointYLabel = -3.0f;
static CGFloat fontSize = 10.0f;

@implementation BBButtonWithIndicator

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-pointXLabel, pointYLabel, sizeLabel, sizeLabel)];
        self.label.backgroundColor = [BBConstantAndColor applicationOrangeColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:fontSize];
        self.label.clipsToBounds = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.layer.masksToBounds = YES;
        self.label.layer.cornerRadius = CGRectGetHeight(self.label.frame)/2;
        [self addSubview:self.label];
    }
    return self;
}


@end
