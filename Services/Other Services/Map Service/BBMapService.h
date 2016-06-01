//
//  BBMapService.h
//  JustForYou
//
//  Created by Антон on 01.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMapService : NSObject

+ (instancetype) sharedService;

- (NSString *)currentApiKeyMap;

@end
