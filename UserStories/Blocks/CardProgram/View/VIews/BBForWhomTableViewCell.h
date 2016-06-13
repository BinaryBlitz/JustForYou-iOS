//
//  BBForWhomTableViewCell.h
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBForWhomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;

@property (strong, nonatomic) NSString *first;
@property (strong, nonatomic) NSString *second;
@property (strong, nonatomic) NSString *third;

- (void)setDescriptions:(NSString *)first :(NSString *)second :(NSString *)third;

@end
