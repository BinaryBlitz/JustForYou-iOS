//
//  BBSegmentedControl.m
//  JustForYou
//
//  Created by Антон on 10.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBSegmentedControl.h"

@implementation BBSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setTestAtributed];
    }
    
    return self;
}

- (void)setTestAtributed {
    UIFont *systemFont = [UIFont boldSystemFontOfSize:12.0f];
    
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                  systemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [BBConstantAndColor applicationOrangeColor], NSForegroundColorAttributeName,
                                  systemFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
}



@end
