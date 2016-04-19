//
//  BBCalendarService.m
//  JustForYou
//
//  Created by Антон on 19.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBCalendarService.h"

@interface BBCalendarService()

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation BBCalendarService

+ (instancetype) sharedService {
    static BBCalendarService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BBCalendarService alloc] init];
    });
    return service;
}

@end
