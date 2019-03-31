//
//  Person.m
//  CopyTest2
//
//  Created by 永平 on 2019/3/28.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "Person.h"

@implementation Person

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.age = [aDecoder decodeIntegerForKey:@"age"];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeInteger:self.age forKey:@"age"];
//}

- (NSString *)description {
    NSString *content = [NSString stringWithFormat:@"我叫%@, 今年%zd岁",self.name,self.age];
    return content;
}

@end
