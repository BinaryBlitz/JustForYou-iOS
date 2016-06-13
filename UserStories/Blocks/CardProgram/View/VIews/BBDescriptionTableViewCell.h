//
//  BBDescriptionTableViewCell.h
//  JustForYou
//
//  Created by Антон on 15.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProgram.h"

@interface BBDescriptionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigCostLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) BBProgram *program;

- (void)reloadUIWithProgram:(BBProgram *)program;

@end
