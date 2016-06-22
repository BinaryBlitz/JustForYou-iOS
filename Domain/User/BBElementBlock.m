//
//  BBElementBlock.m
//  JustForYou
//
//  Created by Антон on 21.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBElementBlock.h"

@implementation BBElementBlock

- (instancetype)initWithProgramId:(NSInteger)programId {
    self = [super init];
    if (self) {
        BBProgram *program = [BBProgram objectsWhere:[NSString stringWithFormat:@"programId=%ld", (long)programId]].firstObject;
        self.colorBlock = [BBConstantAndColor colorForIdBlock:program.block.blockId];
        self.nameBlock = program.block.name;
    }
    return self;
}

@end
