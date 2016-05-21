//
//  BBMyProgramsViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBMyProgramsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)didSelectRowWithProgram:(NSInteger)program;

@end