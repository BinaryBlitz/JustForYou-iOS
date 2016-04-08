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

@end
