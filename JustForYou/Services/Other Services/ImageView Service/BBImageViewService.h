#import <Foundation/Foundation.h>

//#import <Haneke.h>

#import "BBImageWithLoader.h"

@interface BBImageViewService : NSObject

+ (instancetype) sharedService;

- (void) setImageForImageView:(BBImageWithLoader *)imageView placeholder:(UIImage *)placeholder stringURL:(NSString *)url;

@end
