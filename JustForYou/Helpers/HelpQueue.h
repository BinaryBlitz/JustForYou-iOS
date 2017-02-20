#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef void(^CodeBlock)(void);

void HQDispatchToMainQueue(CodeBlock);
void HQDispatchToBackgroundQueue(CodeBlock);
void HQDispatchAfter(CGFloat, CodeBlock);
void HQDispatchToRealmQueue(CodeBlock block);
