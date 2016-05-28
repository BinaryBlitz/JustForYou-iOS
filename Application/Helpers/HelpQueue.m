//
//  HelpQueue.m
//  binaryTest
//
//  Created by Антон on 12.03.16.
//  Copyright © 2016 DevT. All rights reserved.
//

#import "HelpQueue.h"

void HQDispatchToMainQueue(CodeBlock block) {
    if ([NSThread isMainThread]) {
        if (block) {
            block();
        }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^ {
            if (block) {
                block();
            }
        });
    }
}

void HQDispatchToBackgroundQueue(CodeBlock block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^ {
        if (block) {
            block();
        }
    });
}

void HQDispatchAfter(CGFloat time, CodeBlock block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}
