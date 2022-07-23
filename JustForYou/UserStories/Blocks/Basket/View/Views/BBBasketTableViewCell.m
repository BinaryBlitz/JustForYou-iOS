

#import "BBUserService.h"

static NSString *kNameMinusImage = @"minusIcon";
static NSString *kNameCrossImage = @"crossIcon";

@implementation BBBasketTableViewCell {
  NSInteger oldTotal;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

#pragma mark - Setters Methods

- (void)setProgram:(BBProgram *)program {
  _program = program;
  self.subnameLabel.text = program.block.name;
  self.nameLabel.text = program.name;
}

- (void)setOrderProgram:(BBOrderProgram *)orderProgram {
  _orderProgram = orderProgram;
  NSInteger daysCount = self.orderProgram.days.count;
  NSString *days = [BBConstantAndColor getNumberEndingWith:daysCount andEndings:@[@"день", @"дня", @"дней"]];
  self.countLabel.text = [NSString stringWithFormat:@"%ld %@", (long) daysCount, days];
  if (daysCount >= 2) {
    [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
  } else {
    [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
  }
}

- (void)totalForCountDays {
  NSString *totalString;
  NSInteger total = 0;
  NSInteger daysCount = self.orderProgram.days.count;
  NSString *days = [BBConstantAndColor getNumberEndingWith:daysCount andEndings:@[@"день", @"дня", @"дней"]];
  if (self.orderProgram.days.count >= self.program.threshold) {
    total = self.program.secondaryPrice * daysCount;
    totalString = [NSString stringWithFormat:@"%ld*%ld %@ = %ld", (long) self.program.secondaryPrice, (long) daysCount, days, (long) total];
  } else {
    total = self.program.primaryPrice * daysCount;
    totalString = [NSString stringWithFormat:@"%ld*%ld %@ = %ld", (long) self.program.primaryPrice, (long) daysCount, days, (long) total];
  }
  self.costLabel.text = totalString;
  oldTotal = total;
}

#pragma mark - UI Methods

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect contentViewFrame = self.contentView.frame;
  contentViewFrame.origin.x = sideOffsetCell;
  contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell * 2;
  contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - sideOffsetCell;
  self.contentView.frame = contentViewFrame;
}

- (void)drawRect:(CGRect)rect {

  CAShapeLayer *borderLayer = [self _createBorderLayer];
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
  maskLayer.path = maskPath.CGPath;
  borderLayer.path = maskPath.CGPath;
  self.contentView.layer.mask = maskLayer;
  [self.contentView.layer addSublayer:borderLayer];
}

- (CAShapeLayer *)_createBorderLayer {
  CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
  borderLayer.frame = self.contentView.bounds;
  borderLayer.lineWidth = borderWightLineCell;
  borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
  borderLayer.fillColor = [UIColor clearColor].CGColor;

  return borderLayer;
}

#pragma mark - Actions Methods

- (IBAction)closeButtonAction:(id)sender {
  if ([self.delegate respondsToSelector:@selector(closeButtonDidTapWithBasketCell:)]) {
    [self.delegate closeButtonDidTapWithBasketCell:self];
  }
}

- (IBAction)leftButtonAction:(id)sender {
}

- (IBAction)rightButtonAction:(id)sender {
}

- (void)_changeBackgroundImageInButtonWithName:(NSString *)image {
  [self.leftButton setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

@end
