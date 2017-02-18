#import "BBReplacementCategory.h"

#import "BBUserService.h"

@implementation BBReplacementCategory

- (instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.categoryId = [[JSONObj valueForKey:@"id"] integerValue];
        self.nameCategory = [JSONObj valueForKey:@"name"];
        self.products = [self parseProductsWithJSON:[JSONObj valueForKey:@"products"]];
    }
    return self;
}

- (NSArray *)parseProductsWithJSON:(id)JSONObj {
    NSMutableArray *products = [NSMutableArray array];
    BOOL setProguct = YES;
    NSArray *arrayUser = [[BBUserService sharedService] currentReplacementUser];
    if ([JSONObj isKindOfClass:[NSArray class]]) {
        for (id obj in JSONObj) {
            BBReplacementProduct *product = [[BBReplacementProduct alloc] initWithJSON:obj];
            if ([arrayUser count] != 0) {
                setProguct = YES;
                for (BBReplacementProduct *userProd in arrayUser) {
                    if (userProd.productId == product.productId) {
                        setProguct = NO;
                    }
                }
                if (setProguct) {
                    [products addObject:product];
                }
            } else {
                [products addObject:product];
            }
        }
    }
    return products;
}

@end

