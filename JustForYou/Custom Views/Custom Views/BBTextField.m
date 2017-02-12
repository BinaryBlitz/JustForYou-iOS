//
//  BBTextField.m
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBTextField.h"

@implementation BBTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

@end
