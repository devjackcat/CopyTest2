//
//  Item.m
//  CopyTest
//
//  Created by 永平 on 2019/3/25.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "Item.h"

@interface Item () <NSCoding>
@property (nonatomic, copy) NSString *title;
@end

@implementation Item

+ (instancetype)item {
    int x = arc4random() % 100;
    Item *i = [[Item alloc] init];
    i.title = [NSString stringWithFormat:@"%d",x];
    return i;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
}

- (NSString *)description {
    NSString *content = [NSString stringWithFormat:@"           title = %@, pointer = %p",self.title,self];
    return content;
}

@end
