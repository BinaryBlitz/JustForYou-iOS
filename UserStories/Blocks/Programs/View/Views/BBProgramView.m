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

- (void)setProgramInUI:(BBProgram *)program {
    self.program = program;
    self.shortDescription.text = self.program.shortDescript;
    NSString *day = @"";
    if (self.program.threshold == 1) {
        day = [NSString stringWithFormat:@"При заказе от %ld дня: %ld Р",(long)self.program.threshold, (long)self.program.secondaryPrice];
    } else {
        day = [NSString stringWithFormat:@"При заказе от %ld дней: %ld Р",(long)self.program.threshold, (long)self.program.secondaryPrice];
    }
    for (BBProgramView *view in self.subviews) {
        [self _setValuesForView:view dayString:day];
    }
    [self _setValuesForView:self dayString:day];
}

- (void)_setValuesForView:(BBProgramView *)view dayString:(NSString *)day {
    view.nameProgram.text = self.program.name;
    view.descriptionProgram.text = self.program.descript;
    view.costProgram.text = [NSString stringWithFormat:@"Цена за 1 день: %ld Р", (long)self.program.primaryPrice];
    view.bigCostProgram.text = day;
}

@end
