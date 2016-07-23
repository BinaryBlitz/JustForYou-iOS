//
//  BBAddBasketViewPopover.m
//  JustForYou
//
//  Created by Антон on 23.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddBasketViewPopover.h"

static CGFloat cornerRadius = 10.0f;

static NSString *kNameMinusImage = @"minusIcon";
static NSString *kNameCrossImage = @"crossIcon";

@interface BBAddBasketViewPopover()

@property (nonatomic) NSUInteger countDays;
@property (nonatomic) NSInteger threshold;
@property (nonatomic) NSInteger primary;
@property (nonatomic) NSInteger secondary;

@end

@implementation BBAddBasketViewPopover

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSelfFromNib];
        self.countDays = 1;
    }
    return self;
}

//- (void)layoutSubviews {
//    self.countDays = 1;
//    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
//    [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
//}



- (void) createSelfFromNib {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBAddBasketViewPopover" owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    [self.contentView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.4f]];
    self.popoverView.layer.masksToBounds = YES;
    self.popoverView.layer.cornerRadius = cornerRadius;
    self.contentView.frame = self.bounds;
}

- (void)setPrimaryPrice:(NSInteger)primary secondary:(NSInteger)secondary threshold:(NSInteger)threshold {
    self.primary = primary;
    self.secondary = secondary;
    self.threshold = threshold;
    self.countDays = threshold;
    [self changeTotalCost];
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
}

- (void)changeTotalCost {
    NSString *total;
    if (self.countDays >= self.threshold) {
        total = [NSString stringWithFormat:@"%ld*%lu = %lu P", (long)self.secondary, (unsigned long)self.countDays, (unsigned long)(self.secondary * self.countDays)];
    } else {
        total = [NSString stringWithFormat:@"%ld*%lu = %lu P", (long)self.primary, (unsigned long)self.countDays, (unsigned long)(self.primary * self.countDays)];
    }
    self.totalCost.text = total;
}

#pragma mark - Actions

- (IBAction)minusButtonAction:(id)sender {
    if (self.countDays > 2) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    } else {
        [self _changeBackgroundImageInButtonWithName:kNameCrossImage];
    }
    if (self.countDays != 1) {
        self.countDays--;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
    [self changeTotalCost];
}

- (IBAction)plusButtonAction:(id)sender {
    if (self.countDays == 1) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    }
    self.countDays++;
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
    [self changeTotalCost];
}

- (IBAction)okButtonAction:(id)sender {
    [self.delegate okButtonDidTapWithCountDays:self.countDays];
    self.countDays = self.threshold;
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
    [self changeTotalCost];
}

- (void)_changeBackgroundImageInButtonWithName:(NSString *)image {
    [self.minusButton setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                forState:UIControlStateNormal];
}

@end
