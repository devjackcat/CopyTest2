//
//  ClassRoom.h
//  CopyTest2
//
//  Created by 永平 on 2019/3/31.
//  Copyright © 2019 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassRoom : NSObject
/** 班级号 **/
@property (nonatomic, copy) NSString *classNo;
/** 班级学生 **/
@property (nonatomic, strong) NSArray<Student*> *students;
@end

NS_ASSUME_NONNULL_END
