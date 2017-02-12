//
//  BBAppAnalitics.h
//  JustForYou
//
//  Created by Антон on 07.11.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAppAnalitics : NSObject

+ (instancetype) sharedService;

- (void)sendControllerWithName:(NSString *)name;
- (void)sendUIActionWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label;

@end
