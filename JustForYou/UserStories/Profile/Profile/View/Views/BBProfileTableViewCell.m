

@implementation BBProfileTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self _layoutImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)_layoutImageView {
  self.avatarImageView.layer.masksToBounds = YES;
  self.avatarImageView.layer.cornerRadius = CGRectGetHeight(self.avatarImageView.frame) / 2;
}

@end
