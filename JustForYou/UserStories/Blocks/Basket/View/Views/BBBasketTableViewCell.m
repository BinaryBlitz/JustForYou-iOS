

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
  self.indicatorView.backgroundColor = [BBConstantAndColor colorForR:program.block.red G:program.block.green B:program.block.blue alpha:1.0f];
  self.nameLabel.text = program.name;
}

- (void)setOrderProgram:(BBOrderProgram *)orderProgram {
  _orderProgram = orderProgram;
  NSString *days = [BBConstantAndColor getNumberEndingWith:orderProgram.countDays andEndings:@[@"день", @"дня", @"дней"]];
  self.countLabel.text = [NSString stringWithFormat:@"%ld %@", (long) orderProgram.countDays, days];
  if (self.orderProgram.countDays >= 2) {
    [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
  } else {
    [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
  }
}

- (NSInteger)totalForCountDays {
  NSString *totalString;
  NSInteger total = 0;
  NSString *days = [BBConstantAndColor getNumberEndingWith:self.orderProgram.countDays andEndings:@[@"день", @"дня", @"дней"]];
  if (self.orderProgram.countDays >= self.program.threshold) {
    total = self.program.secondaryPrice * self.orderProgram.countDays;
    totalString = [NSString stringWithFormat:@"%ld*%ld %@ = %ld", (long) self.program.secondaryPrice, (long) self.orderProgram.countDays, days, (long) total];
  } else {
    total = self.program.primaryPrice * self.orderProgram.countDays;
    totalString = [NSString stringWithFormat:@"%ld*%ld %@ = %ld", (long) self.program.primaryPrice, (long) self.orderProgram.countDays, days, (long) total];
  }
  self.costLabel.text = totalString;
  oldTotal = total;
  return total;
}

#pragma mark - UI Methods

- (void)layoutSubviews {
  [super layoutSubviews];
  self.indicatorView.layer.masksToBounds = YES;
  self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame) / 2;

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
  if (self.orderProgram.countDays > 2) {
    [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
  } else {
    [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
  }
  if (self.orderProgram.countDays != 1) {
    self.orderProgram.countDays--;
  }
  [[BBUserService sharedService] updateOrderProgramWithOrderProgram:self.orderProgram];
  [self _recalculationTotal];
  NSString *days = [BBConstantAndColor getNumberEndingWith:self.orderProgram.countDays andEndings:@[@"день", @"дня", @"дней"]];
  self.countLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long) self.orderProgram.countDays, days];
  [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"cart" action:@"minus" label:self.program.name];
}

- (IBAction)rightButtonAction:(id)sender {
  if (self.orderProgram.countDays == 1) {
    [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
  }
  self.orderProgram.countDays++;
  [[BBUserService sharedService] updateOrderProgramWithOrderProgram:self.orderProgram];
  [self _recalculationTotal];
  NSString *days = [BBConstantAndColor getNumberEndingWith:self.orderProgram.countDays andEndings:@[@"день", @"дня", @"дней"]];
  self.countLabel.text = [NSString stringWithFormat:@"%lu %@", (unsigned long) self.orderProgram.countDays, days];
  [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"cart" action:@"plus" label:self.program.name];
}

- (void)_recalculationTotal {
  NSInteger old = oldTotal;
  NSInteger new = [self totalForCountDays];
  if ([self.delegate respondsToSelector:@selector(oldTotal:newTotal:)]) {
    [self.delegate oldTotal:old newTotal:new];
  }
}

- (void)_changeBackgroundImageInButtonWithName:(NSString *)image {
  [self.leftButton setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

@end