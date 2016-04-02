//
//  BBTextTableViewCell.h
//  JustForYou
//
//  Created by Антон on 28.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBTextTableViewCell : UITableViewCell

- (void)setPlaceholderInTextField:(NSString *)placeholder;

- (NSString *)getTextFromTextField;

@end
