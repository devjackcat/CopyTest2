//
//  Student.h
//  CopyTest2
//
//  Created by 永平 on 2019/3/31.
//  Copyright © 2019 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

/** 姓名 **/
@property (nonatomic, copy) NSString *name;
/** 博客URL **/
@property (nonatomic, strong) NSURL *blogUrl;
/** 年龄 **/
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
