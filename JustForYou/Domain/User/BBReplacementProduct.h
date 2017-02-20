#import <Foundation/Foundation.h>

@interface BBReplacementProduct : NSObject

@property (assign, nonatomic) NSInteger substId;
@property (assign, nonatomic) NSInteger productId;
@property (strong, nonatomic) NSString *nameProduct;

- (instancetype)initWithJSON:(id)JSONObj;

@end
