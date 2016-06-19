//
//  BBOrderProgram.m
//  JustForYou
//
//  Created by Антон on 14.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBOrderProgram.h"


NSString* const kProgramId = @"kProgramId";
NSString* const kCountDays = @"kCountDays";

@implementation BBOrderProgram

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.programId = [coder decodeIntegerForKey:kProgramId];
        self.countDays = [coder decodeIntegerForKey:kCountDays];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.programId forKey:kProgramId];
    [aCoder encodeInteger:self.countDays forKey:kCountDays];

}

@end