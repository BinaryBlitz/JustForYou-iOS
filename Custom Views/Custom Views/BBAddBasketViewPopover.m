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

- (void) createSelfFromNib {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBAddBasketViewPopover"
                                                          owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    [self.contentView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.4f]];
    self.popoverView.layer.masksToBounds = YES;
    self.popoverView.layer.cornerRadius = cornerRadius;
    self.contentView.frame = self.bounds;
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
}

- (IBAction)plusButtonAction:(id)sender {
    if (self.countDays == 1) {
        [self _changeBackgroundImageInButtonWithName:kNameMinusImage];
    }
    self.countDays++;
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
}

- (IBAction)okButtonAction:(id)sender {
    [self.delegate okButtonDidTapWithCountDays:self.countDays];
    self.countDays = 1;
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.countDays];
}

- (void)_changeBackgroundImageInButtonWithName:(NSString *)image {
    [self.minusButton setBackgroundImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
}

@end
