//
//  BBAddBasketViewPopover.m
//  JustForYou
//
//  Created by Антон on 23.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddBasketViewPopover.h"

@implementation BBAddBasketViewPopover

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSelfFromNib];
    }
    return self;
}

- (void) createSelfFromNib {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBAddBasketViewPopover"
                                                          owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    [self addSubview:mainView];
    self.contentView.frame = self.bounds;
}



@end
