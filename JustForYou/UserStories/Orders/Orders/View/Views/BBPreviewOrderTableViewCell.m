#import "BBPreviewOrderTableViewCell.h"

#import "BBCalendarService.h"

@interface BBPreviewOrderTableViewCell ()

@end

@implementation BBPreviewOrderTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setOrder:(BBOrder *)order {
  _order = order;
  if (![order isInvalidated]) {
    self.nameProgramLabel.text = order.nameProgram;
    self.descriptLabel.text = order.nameBlock;
    self.indicatorView.backgroundColor = [UIColor colorWithRed:order.red green:order.green blue:order.blue alpha:1.0f];
    self.adresLabel.text = order.address;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:order.scheduledDay];
    NSInteger startHour = [components hour];
    NSInteger startMinute = [components minute];
    NSInteger endHour = startHour + 1;
    if (startMinute == 0) {
      self.timeLabel.text = [NSString stringWithFormat:@"%ld:00 - %ld:00", (long) startHour, (long) endHour];
    } else {
      self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld - %ld:%ld", (long) startHour, (long) startMinute, (long) endHour, (long) startMinute];
    }
  }
}

- (IBAction)deleteButtonAction:(id)sender {
  if ([self.delegate respondsToSelector:@selector(deleteButtonDidTapWithOrder:)]) {
    [self.delegate deleteButtonDidTapWithOrder:self.order];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.indicatorView.layer.masksToBounds = YES;
  self.indicatorView.layer.cornerRadius = CGRectGetHeight(self.indicatorView.frame) / 2;

  CGRect contentViewFrame = self.contentView.frame;
  contentViewFrame.origin.x = sideOffsetCell;
  contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell * 2;
  contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - bottomOffsetCells;
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

@end
