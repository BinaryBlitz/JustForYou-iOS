//
//  BBBlockTableViewCell.h
//  JustForYou
//
//  Created by Антон on 06.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBBlockTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageBlock;
@property (weak, nonatomic) IBOutlet UILabel *nameBlock;
@property (weak, nonatomic) IBOutlet UILabel *numberProgramInBlock;

@property (assign, nonatomic) NSInteger blockId;

@end
