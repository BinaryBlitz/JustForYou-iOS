//
//  BBBlockTableViewCell.h
//  JustForYou
//
//  Created by Антон on 06.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBImageWithLoader.h"

@interface BBBlockTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BBImageWithLoader *imageBlock;
@property (weak, nonatomic) IBOutlet UILabel *nameBlock;
@property (weak, nonatomic) IBOutlet UILabel *numberProgramInBlock;

@property (assign, nonatomic) NSInteger blockId;

- (void)setCountProgram:(NSInteger)programs;

@end
