//
//  BBCalendarMenuView.m
//  JustForYou
//
//  Created by Антон on 20.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarMenuView.h"

@implementation BBCalendarMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSelfFromNib];
    }
    return self;
}

- (void) createSelfFromNib {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBCalendarMenuView" owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    self.contentView.frame = self.bounds;
}

- (IBAction)leftButtonAction:(id)sender {
    [self.delegate leftButtonDidTap];
}


- (IBAction)rightButtonAction:(id)sender {
    [self.delegate rightButtonDidTap];
}


@end
