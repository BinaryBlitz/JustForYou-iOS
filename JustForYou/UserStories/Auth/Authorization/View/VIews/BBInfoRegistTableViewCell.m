#import "BBInfoRegistTableViewCell.h"

@interface BBInfoRegistTableViewCell ()

@end

@implementation BBInfoRegistTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.keyStyleCell = kBigInfoRegistCellStyle;
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (IBAction)sendAgainButton:(id)sender {
  self.sendAgainButton.enabled = NO;
  HQDispatchAfter(5, ^{
    self.sendAgainButton.enabled = YES;
  });
  [self.delegate sengAgainButtonDidTap];
}

- (void)drawRect:(CGRect)rect {
  if (self.keyStyleCell == kBigInfoRegistCellStyle) {
    self.infoLabel.hidden = YES;
    self.sendAgainButton.hidden = YES;
    self.firstInfoLabel.hidden = NO;
  } else {
    self.infoLabel.hidden = NO;
    self.sendAgainButton.hidden = NO;
    self.firstInfoLabel.hidden = YES;
  }
}

@end
