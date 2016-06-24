//
//  BBElementBlock.h
//  JustForYou
//
//  Created by Антон on 21.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBElementBlock : NSObject

@property (strong, nonatomic) NSString *nameBlock;
@property (strong, nonatomic) UIColor *colorBlock;

- (instancetype)initWithBlockId:(NSInteger)blockId;

@end
