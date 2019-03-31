//
//  Student.m
//  CopyTest2
//
//  Created by 永平 on 2019/3/31.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "Student.h"

@implementation Student
- (NSString *)description {
    NSMutableString * content = [NSMutableString string];
    [content appendString:@"   --------------------\n"];
    [content appendFormat:@"   -- self p1 = %p p2 = %p\n",&self,self];
    [content appendFormat:@"   -- name p1 = %p p2 = %p %@\n",&_name,_name,_name];
    [content appendFormat:@"   -- blogUrl p1 = %p p2 = %p %@\n",&_blogUrl,_blogUrl,_blogUrl.absoluteString];
    [content appendFormat:@"   -- age p1 = %p %zd",&_age,_age];
    return [content copy];
}
@end
