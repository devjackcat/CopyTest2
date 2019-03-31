//
//  NSObject+JCS_DeepCopy.m
//  CopyTest2
//
//  Created by 永平 on 2019/3/29.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "NSObject+JCS_DeepCopy.h"
#import <objc/runtime.h>

@implementation NSObject (JCS_DeepCopy)

- (id)jcs_deepCopy {
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [self arrayDeepCopy:(NSArray*)self];
        
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        return [self dictDeepCopy:(NSDictionary*)self];
        
    } else if ([self isKindOfClass:[NSString class]]) {
        return [self copy];
        
    } else if ([self isKindOfClass:[NSURL class]]) {
        return [self urlDeepCopy:(NSURL*)self];
        
    } else {
        return [self objectDeepCopy:self];
    }
    return nil;
}

///拷贝字典
- (NSDictionary*)dictDeepCopy:(NSDictionary*)oriObj {
    BOOL mutable = [oriObj isKindOfClass:[NSMutableDictionary class]];
    NSMutableDictionary *copiedDict = [NSMutableDictionary dictionary];
    for (id key in oriObj.allKeys) {
        copiedDict[key] = [oriObj[key] jcs_deepCopy];
    }
    return mutable ? copiedDict : [copiedDict copy];
}

///拷贝数组
- (NSArray*)arrayDeepCopy:(NSArray*)oriObj {
    BOOL mutable = [oriObj isKindOfClass:[NSMutableArray class]];
    NSMutableArray *array = [NSMutableArray array];
    for (id item in oriObj) {
        id copiedItem = [item jcs_deepCopy];
        [array addObject:copiedItem];
    }
    return mutable ? array : [array copy];
}

///拷贝字符串
- (NSString*)stringDeepCopy:(NSString*)oriObj {
    return [oriObj copy];
}

///拷贝URL
- (NSURL*)urlDeepCopy:(NSURL*)oriObj {
    NSURL *url = [NSURL URLWithString:oriObj.absoluteString];
    return url;
}

///拷贝自定义对象
- (id)objectDeepCopy:(NSObject*)oriObj {
    //oriObj的类型
    Class clazz = oriObj.class;
    if (!clazz) { return nil; }
    //创建新对象
    id copiedObj = [clazz new];
    unsigned int varCount = 0;
    Ivar * ivars = class_copyIvarList(clazz, &varCount);
    for (unsigned int i = 0; i < varCount; i ++) {
        Ivar ivar = ivars[i];
        //成员变量名
        NSString *name = [@(ivar_getName(ivar)) substringFromIndex:1];
        //设置值
        id value = [self valueForKey:name];
        [copiedObj setValue:[value jcs_deepCopy] forKey:name];
    }
    free(ivars);
    return copiedObj;
}

@end
