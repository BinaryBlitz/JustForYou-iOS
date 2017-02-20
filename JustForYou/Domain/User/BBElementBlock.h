#import <Foundation/Foundation.h>

@interface BBElementBlock : NSObject

@property (strong, nonatomic) NSString *nameBlock;
@property (strong, nonatomic) UIColor *colorBlock;

- (instancetype)initWithBlockId:(NSInteger)blockId;

@end
