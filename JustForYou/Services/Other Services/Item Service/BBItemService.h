#import <Foundation/Foundation.h>

#import "BBButtonWithIndicator.h"

typedef void (^Completion)(void);

@interface BBItemService : NSObject

+ (instancetype)sharedService;

- (UIBarButtonItem *)basketItemWithCallback:(Completion)completion;

- (void)updateImageInBarButtonItem:(UIBarButtonItem *)item forImage:(NSString *)name;

- (void)setHiddenLabelInItem:(UIBarButtonItem *)item hidden:(BOOL)hidden;

@end

