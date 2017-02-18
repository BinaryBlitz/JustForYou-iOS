#import "BBMyProgramTableViewCell.h"

@implementation BBMyProgramTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.keyMode = kProgramCellModeDefault;
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setPurchases:(BBPurchases *)purchases {
  _purchases = purchases;
  self.nameLabel.text = purchases.nameProgram;
  self.countDayLabel.textColor = [UIColor blackColor];
  self.countDayLabel.font = [UIFont systemFontOfSize:15.0f];
  NSString *days = [BBConstantAndColor getNumberEndingWith:purchases.countDays andEndings:@[@"день", @"дня", @"дней"]];
  self.countDayLabel.text = [NSString stringWithFormat:@"%ld %@", (long) purchases.countDays, days];
  self.indicatorView.backgroundColor = purchases.elementBlock.colorBlock;
  self.subNameLabel.text = purchases.elementBlock.nameBlock;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.indicatorView.layer.masksToBounds = YES;
  self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame) / 2;

  if (self.keyMode == kProgramCellModeCornerRadius) {
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = sideOffsetCell;
    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell * 2;
    contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - bottomOffsetCells;
    self.contentView.frame = contentViewFrame;
  }
}

- (void)drawRect:(CGRect)rect {
  if (self.keyMode == kProgramCellModeCornerRadius) {
    CAShapeLayer *borderLayer = [self _createBorderLayer];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
    maskLayer.path = maskPath.CGPath;
    borderLayer.path = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
    [self.contentView.layer addSublayer:borderLayer];
  }
}

- (CAShapeLayer *)_createBorderLayer {
  CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
  borderLayer.frame = self.contentView.bounds;
  borderLayer.lineWidth = borderWightLineCell;
  borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
  borderLayer.fillColor = [UIColor clearColor].CGColor;

  return borderLayer;
}

@end
