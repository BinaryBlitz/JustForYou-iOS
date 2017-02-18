#import "BBPartDayTableViewCell.h"

@implementation BBPartDayTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setPartOfDayWithKey:(BBPartOfDay)key {
  if (key == kMorningPartOfDay) {
    self.partOfDayLabel.text = @"УТРО";
  } else if (key == kDayPartOfDay) {
    self.partOfDayLabel.text = @"ДЕНЬ";
  } else {
    self.partOfDayLabel.text = @"ВЕЧЕР";
  }
}

@end
