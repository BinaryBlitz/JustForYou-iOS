#import "BBReplacementProduct.h"

NSString* const kName = @"kName";
NSString* const kProductId = @"kProductId";
NSString* const kSubstId = @"kSubstId";

@implementation BBReplacementProduct

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.productId = [[JSONObj valueForKey:@"id"] integerValue];
        self.nameProduct = [JSONObj valueForKey:@"name"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.nameProduct = [coder decodeObjectForKey:kName];
        self.productId = [coder decodeIntegerForKey:kProductId];
        self.substId = [coder decodeIntegerForKey:kSubstId];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.productId forKey:kProductId];
    [aCoder encodeObject:self.nameProduct forKey:kName];
    [aCoder encodeInteger:self.substId forKey:kSubstId];
}

@end
