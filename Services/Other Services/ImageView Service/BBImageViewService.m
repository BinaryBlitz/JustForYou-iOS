 //
//  BBImageViewService.m
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBImageViewService.h"
#import <SDWebImage/UIImageView+WebCache.h>

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

- (void)setImageForImageView:(UIImageView *)imageView placeholder:(UIImage *)placeholder stringURL:(NSString *)url {
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
