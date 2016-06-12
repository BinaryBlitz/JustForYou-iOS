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
    BBProgramView *view = self.subviews.lastObject;
    view.nameProgram.text = program.name;
    view.descriptionProgram.text = program.descript;
    view.costProgram.text = [NSString stringWithFormat:@"Цена за 1 день: %ld Р", (long)program.primaryPrice];
    view.bigCostProgram.text = [NSString
                                stringWithFormat:@"При заказе от %ld дней: %ld Р",(long)program.threshold, (long)program.secondaryPrice];
}

@end
