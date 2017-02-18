#import "BBHeaderTableViewCell.h"

@implementation BBHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addTapForImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addTapForImageView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSmallImage)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.imageProgram addGestureRecognizer:tap];
}

- (void)didTapSmallImage {
    if ([self.delegate respondsToSelector:@selector(imageViewDidTapWithImage:)]) {
        [self.delegate imageViewDidTapWithImage:self.imageProgram.image];
    }
}

- (IBAction)segmentedControlAction:(id)sender {
    [self.segmentedControl setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(segmentedControlValueChange:)]) {
        [self.delegate segmentedControlValueChange:self.segmentedControl.selectedSegmentIndex];
    }
}

- (void)drawRect:(CGRect)rect {
    [self.contentView sendSubviewToBack:self.imageProgram];
}

@end
