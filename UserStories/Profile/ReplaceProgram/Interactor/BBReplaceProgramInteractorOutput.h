//
//  BBReplaceProgramInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplaceProgramInteractorOutput <NSObject>

- (void)allProgramsWithArray:(NSArray *)programs;

- (void)exchangeWithPayId:(NSInteger)payId payURL:(NSString *)url;

- (void)errorNetwork;
- (void)errorServer;
- (void)paymentSuccessfull;
- (void)paymentError;

@end