//
//  BBProgramView.m
//  JustForYou
//
//  Created by Антон on 08.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBProgramView.h"

@implementation BBProgramView


#pragma mark - Instancetype Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSelfFromNib];
    }
    return self;
}

- (void) createSelfFromNib {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBProgramView" owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    self.contentView.frame = self.bounds;
}

- (IBAction)moreButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(moreButtonDidTap)]) {
        [self.delegate moreButtonDidTap];
    }
}

- (void)setProgramInUI:(BBProgram *)program {
    self.program = program;
    self.shortDescription.text = self.program.shortDescript;
    for (BBProgramView *view in self.subviews) {
        [self _setValuesForView:view];
    }
    [self _setValuesForView:self];
}

- (void)_setValuesForView:(BBProgramView *)view {
    view.nameProgram.text = self.program.name;
    view.costProgram.text = [BBConstantAndColor formatedStringForOneDayWithProgram:self.program];
    view.bigCostProgram.text = [BBConstantAndColor formatedStringForAnyDayWithProgram:self.program];
}

@end
