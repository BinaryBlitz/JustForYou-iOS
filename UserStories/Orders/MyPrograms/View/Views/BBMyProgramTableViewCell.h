//
//  BBMyProgramTableViewCell.h
//  JustForYou
//
//  Created by Антон on 06.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kProgramCellModeCornerRadius,
    kProgramCellModeDefault
}BBKeyProgramCellMode;

@interface BBMyProgramTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (assign, nonatomic) BBKeyProgramCellMode keyMode;

@end
