//
//  BBElementBlock.m
//  JustForYou
//
//  Created by Антон on 21.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBElementBlock.h"

@implementation BBElementBlock

- (instancetype)initWithBlockId:(NSInteger)blockId {
    self = [super init];
    if (self) {
        BBBlock *block = [BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long)blockId]].firstObject;
        self.colorBlock = [BBConstantAndColor colorForIdBlock:blockId];
        self.nameBlock = block.name;
    }
    return self;
}

@end
