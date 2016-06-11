//
//  BBImageViewService.m
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBImageViewService.h"

static NSString *kNameFormat = @"cache";

@implementation BBImageViewService

+ (instancetype) sharedService {
    static BBImageViewService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BBImageViewService alloc] init];
    });
    return service;
}

- (void) setImageForImageView:(UIImageView *)imageView placeholder:(UIImage *)placeholder stringURL:(NSString *)url {
    HNKCacheFormat *format = [[HNKCache sharedCache].formats objectForKey:kNameFormat];
    if (!format) {
        format = [[HNKCacheFormat alloc] initWithName:kNameFormat];
//        format.size = imageView.frame.size;
        format.scaleMode = HNKScaleModeFill;
        //        format.compressionQuality = 0.5;
//        format.diskCapacity = 1 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
    }
    imageView.hnk_cacheFormat = format;
    [imageView hnk_setImageFromURL:[NSURL URLWithString:url] placeholder:placeholder];
}

@end
