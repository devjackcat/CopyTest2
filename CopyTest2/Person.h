//
//  Person.h
//  CopyTest2
//
//  Created by 永平 on 2019/3/28.
//  Copyright © 2019 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding,NSCopying>

/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 年龄 */
@property (nonatomic, assign) NSInteger age;

@end
