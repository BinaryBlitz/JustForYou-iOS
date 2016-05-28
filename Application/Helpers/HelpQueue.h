//
//  HelpQueue.h
//  binaryTest
//
//  Created by Антон on 12.03.16.
//  Copyright © 2016 DevT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef void(^CodeBlock)(void);

void HQDispatchToMainQueue(CodeBlock);
void HQDispatchToBackgroundQueue(CodeBlock);
void HQDispatchAfter(CGFloat, CodeBlock);
