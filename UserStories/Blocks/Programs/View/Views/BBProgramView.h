//
//  BBProgramView.h
//  JustForYou
//
//  Created by Антон on 08.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProgram.h"

@interface BBProgramView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameProgram;
@property (weak, nonatomic) IBOutlet UILabel *costProgram;
@property (weak, nonatomic) IBOutlet UILabel *shortDescription;
@property (weak, nonatomic) IBOutlet UILabel *descriptionProgram;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) BBProgram *program;

- (void)setProgramInUI:(BBProgram *)program;

@end
