//
//  BBTextTableViewCell.h
//  JustForYou
//
//  Created by Антон on 28.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBTextTableViewCell : UITableViewCell

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;
@property (nonatomic) BBKeyStyleContentCell kStyleContentCell;

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (NSString *)getTextFromTextField;
- (void)setPlaceholderInTextField:(NSString *)placeholder;


@end
