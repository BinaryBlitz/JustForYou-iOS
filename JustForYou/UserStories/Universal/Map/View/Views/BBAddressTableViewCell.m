#import "BBAddressTableViewCell.h"

@implementation BBAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateTextLabelWithAddress {
    self.textLabel.text = self.address.street;
}

@end
