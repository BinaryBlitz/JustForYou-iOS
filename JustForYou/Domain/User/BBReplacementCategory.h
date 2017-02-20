#import <Foundation/Foundation.h>

#import "BBReplacementProduct.h"

@interface BBReplacementCategory : NSObject

@property (assign, nonatomic) NSInteger categoryId;
@property (strong, nonatomic) NSString *nameCategory;
@property (strong, nonatomic) NSArray *products;

- (instancetype)initWithJSON:(id)JSONObj;

@end
