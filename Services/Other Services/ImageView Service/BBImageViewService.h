//
//  BBImageViewService.h
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <Haneke.h>



@interface BBImageViewService : NSObject

+ (instancetype) sharedService;

- (void) setImageForImageView:(UIImageView *)imageView placeholder:(UIImage *)placeholder stringURL:(NSString *)url;

@end
