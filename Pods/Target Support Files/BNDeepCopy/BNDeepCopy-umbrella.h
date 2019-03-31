#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BNDeepCopy.h"
#import "BNDeepCopyProtocol.h"
#import "NSArray+BNDeepCopy.h"
#import "NSDictionary+BNDeepCopy.h"
#import "NSSet+BNDeepCopy.h"

FOUNDATION_EXPORT double BNDeepCopyVersionNumber;
FOUNDATION_EXPORT const unsigned char BNDeepCopyVersionString[];

