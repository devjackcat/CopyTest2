//
//  Test.m
//  CopyTest
//
//  Created by 永平 on 2019/3/25.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "Test.h"
#import "Item.h"
#import "Person.h"
#import "ClassRoom.h"
#import "NSObject+JCS_DeepCopy.h"

@interface Test ()

@end

@implementation Test

- (void)run {
    [self test_object_mutableCopy_1];
}

/**
 自定义对象mutableCopy
 */
- (void)test_object_mutableCopy_1 {
    Student *stu1 = [[Student alloc] init];
    stu1.name = @"张三";
    stu1.blogUrl = [NSURL URLWithString:@"http://www.11111.com"];
    stu1.age = 18;
    
    Student *stu2 = [stu1 copy];
    Student *stu3 = [stu1 mutableCopy];
    NSLog(@"-- stu1 = %@",stu1);
    NSLog(@"-- stu2 = %@",stu2);
    NSLog(@"-- stu3 = %@",stu3);
}

- (void)test_runtime_deepcopy_3 {
    
    Student *stu1 = [[Student alloc] init];
    stu1.name = @"张三";
    stu1.blogUrl = [NSURL URLWithString:@"http://www.11111.com"];
    stu1.age = 18;
    
    Student *stu2 = [[Student alloc] init];
    stu2.name = @"李四";
    stu2.blogUrl = [NSURL URLWithString:@"http://www.22222.com"];
    stu2.age = 19;
    
    ClassRoom *c1 = [[ClassRoom alloc] init];
    c1.classNo = @"高三(1)班";
    c1.students = @[stu1,stu2];
    
    ClassRoom *c2 = [c1 jcs_deepCopy];
    
    NSLog(@"-- c1 p1 = %p  p2 = %p %@",&c1,c1,c1.classNo);
    for (Student *stu in c1.students) {
        NSLog(@"%@",stu);
    }
    NSLog(@"-- c2 p1 = %p  p2 = %p %@",&c2,c2,c2.classNo);
    for (Student *stu in c2.students) {
        NSLog(@"%@",stu);
    }
}

- (void)test_runtime_deepcopy_2 {
    Person *p1 = [[Person alloc] init];
    p1.name = @"张三";
    p1.age = 28;
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"李四";
    p2.age = 32;
    
    NSDictionary *oriDict = @{
                              @"person1":p1,
                              @"person2":p2
                              };
    NSDictionary *copiedDict = [oriDict jcs_deepCopy];
    
    NSLog(@"-- oriDict      p1 = %p  p2 = %p ",&oriDict,oriDict);
    for (id value in oriDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedDict   p1 = %p  p2 = %p",&copiedDict,copiedDict);
    for (id value in copiedDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
}

- (void)test_runtime_deepcopy_1 {
    Person *p1 = [[Person alloc] init];
    p1.name = @"张三";
    p1.age = 28;
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"李四";
    p2.age = 32;
    
    NSArray *oriPersons = @[p1,p2];
    NSArray *copiedPersons = [oriPersons jcs_deepCopy];
    
    NSLog(@"-- oriPersons      p1 = %p  p2 = %p ",&oriPersons,oriPersons);
    for (id value in oriPersons) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedPersons   p1 = %p  p2 = %p",&copiedPersons,copiedPersons);
    for (id value in copiedPersons) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
}

- (void)test_dict_deepcopy_2 {
    
    NSDictionary *oriDict = @{
                              @"key1":[NSDictionary dictionary],
                              @"key2":[NSArray array]
                              };
    [[NSUserDefaults standardUserDefaults] setObject:oriDict forKey:@"dict"];
    NSDictionary *copiedDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"dict"];
    NSLog(@"-- oriDict      p1 = %p  p2 = %p ",&oriDict,oriDict);
    for (id value in oriDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedDict   p1 = %p  p2 = %p",&copiedDict,copiedDict);
    for (id value in copiedDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
}

- (void)test_array_deepcopy_2{
    Person *p1 = [[Person alloc] init];
    p1.name = @"张三";
    p1.age = 28;
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"李四";
    p2.age = 32;
    
    NSArray *oriPersons = @[p1,p2];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"persons.data"];
    [NSKeyedArchiver archiveRootObject:oriPersons toFile:path];
    NSArray *copiedPersons = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"-- oriPersons      p1 = %p  p2 = %p ",&oriPersons,oriPersons);
    for (id value in oriPersons) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedPersons   p1 = %p  p2 = %p",&copiedPersons,copiedPersons);
    for (id value in copiedPersons) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
}

/**
 1.局限：数据类型只支持 NSString、NSDictionary、NSArayy、NSData、NSNumber（如果你想的话，可以将基本数据类型转换为NSNumber再进行归档）。
 2.比较方便，设置好归档路径，一句话归档，一句话解档。
 3.归档文件格式：一般保存.plist文件。
 */
- (void)test_dict_deepcopy {
    NSDictionary *oriDict = @{
                               @"key1":@"value1",
                               @"key2":@"value2"
                               };
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"dict.plist"];
    [oriDict writeToFile:path atomically:YES];
    NSDictionary *copiedDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"-- oriDict      p1 = %p  p2 = %p ",&oriDict,oriDict);
    for (id value in oriDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedDict   p1 = %p  p2 = %p",&copiedDict,copiedDict);
    for (id value in copiedDict.allValues) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
}

/**
 1.局限：数据类型只支持 NSString、NSDictionary、NSArayy、NSData、NSNumber（如果你想的话，可以将基本数据类型转换为NSNumber再进行归档）。
 2.比较方便，设置好归档路径，一句话归档，一句话解档。
 3.归档文件格式：一般保存.plist文件。
 */
- (void)test_array_deepcopy_1 {
//    NSArray *oriArray = @[[Item item],[Item item]];
    NSArray *oriArray = @[@"AAA",@"BBB"];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"array_1.txt"];
    [oriArray writeToFile:path atomically:YES];
    NSArray *copiedArray = [NSArray arrayWithContentsOfFile:path];
    
    NSLog(@"-- oriArray      p1 = %p  p2 = %p ",&oriArray,oriArray);
    for (id value in oriArray) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }
    NSLog(@"-- copiedArray   p1 = %p  p2 = %p",&copiedArray,copiedArray);
    for (id value in copiedArray) {
        NSLog(@"--    p1 = %p  p2 = %p %@",&value,value,value);
    }

    NSLog(@"-- path = %@",path);
}

//可变字典(NSMutableDictionary)
- (void)test_6 {
    
    NSMutableDictionary *oriDict = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                   @"key1":[Item item],
                                                                                   @"key2":[Item item]
                                                                                   }];
    NSMutableDictionary *strongDict = oriDict;
    NSDictionary *copiedDict = [oriDict copy];
    NSMutableDictionary *muCopiedDict = [oriDict mutableCopy];
    
    NSLog(@"-- oriDict      p1 = %p  p2 = %p %@",&oriDict,oriDict,oriDict);
    NSLog(@"-- strongDict   p1 = %p  p2 = %p %@",&strongDict,strongDict,strongDict);
    NSLog(@"-- copiedDict   p1 = %p  p2 = %p %@",&copiedDict,copiedDict,copiedDict);
    NSLog(@"-- muCopiedDict p1 = %p  p2 = %p %@",&muCopiedDict,muCopiedDict,muCopiedDict);
    
}

//不可变字典(NSDictionary)
- (void)test_5 {
    
    NSDictionary *oriDict = @{
                               @"key1":[NSObject new],
                               @"key2":[NSObject new]
                               };
    NSDictionary *strongDict = oriDict;
    NSDictionary *copiedDict = [oriDict copy];
    NSDictionary *muCopiedDict = [oriDict mutableCopy];
    
    NSLog(@"-- oriDict      p1 = %p  p2 = %p %@",&oriDict,oriDict,oriDict);
    NSLog(@"-- strongDict   p1 = %p  p2 = %p %@",&strongDict,strongDict,strongDict);
    NSLog(@"-- copiedDict   p1 = %p  p2 = %p %@",&copiedDict,copiedDict,copiedDict);
    NSLog(@"-- muCopiedDict p1 = %p  p2 = %p %@",&muCopiedDict,muCopiedDict,muCopiedDict);
    
}

//可变对象 - 数组
- (void)test_4 {
    
    NSMutableArray *oriArray = [NSMutableArray arrayWithObjects:[NSObject new],[NSObject new], nil];
    NSMutableArray *strongArray = oriArray;
    NSMutableArray *copiedArray = [oriArray copy];
    NSMutableArray *muCopiedArray = [oriArray mutableCopy];
    
    NSLog(@"-- oriArray      p1 = %p  p2 = %p %@",&oriArray,oriArray,oriArray);
    NSLog(@"-- strongArray   p1 = %p  p2 = %p %@",&strongArray,strongArray,strongArray);
    NSLog(@"-- copiedArray   p1 = %p  p2 = %p %@",&copiedArray,copiedArray,copiedArray);
    NSLog(@"-- muCopiedArray p1 = %p  p2 = %p %@",&muCopiedArray,muCopiedArray,muCopiedArray);
    
}

//不可变对象 - 数组
- (void)test_3 {
    
    NSArray *oriArray = @[[NSObject new],[NSObject new]];
    NSArray *strongArray = oriArray;
    NSArray *copiedArray = [oriArray copy];
    NSArray *muCopiedArray = [oriArray mutableCopy];
    
    NSLog(@"-- oriArray      p1 = %p  p2 = %p %@",&oriArray,oriArray,oriArray);
    NSLog(@"-- strongArray   p1 = %p  p2 = %p %@",&strongArray,strongArray,strongArray);
    NSLog(@"-- copiedArray   p1 = %p  p2 = %p %@",&copiedArray,copiedArray,copiedArray);
    NSLog(@"-- muCopiedArray p1 = %p  p2 = %p %@",&muCopiedArray,muCopiedArray,muCopiedArray);
    
}

//可变对象 - 字符串
- (void)test_2 {
    
    NSMutableString *oriStr = [NSMutableString stringWithString:@"abc"];
    NSMutableString *strongStr = oriStr;
    NSMutableString *copiedStr = [oriStr copy];
    NSMutableString *muCopiedStr = [oriStr mutableCopy];
    
    NSLog(@"-- oriStr = %@      p1 = %p  p2 = %p",oriStr,&oriStr,oriStr);
    NSLog(@"-- strongStr = %@   p1 = %p  p2 = %p",strongStr,&strongStr,strongStr);
    NSLog(@"-- copiedStr = %@   p1 = %p  p2 = %p",copiedStr,&copiedStr,copiedStr);
    NSLog(@"-- muCopiedStr = %@ p1 = %p  p2 = %p",muCopiedStr,&muCopiedStr,muCopiedStr);
}

//不可变对象 - 字符串
- (void)test_1 {
    
    NSString *oriStr = @"abc";
    NSString *strongStr = oriStr;
    NSString *copiedStr = [oriStr copy];
    NSString *muCopiedStr = [oriStr mutableCopy];
    
    NSLog(@"-- oriStr = %@      p1 = %p  p2 = %p",oriStr,&oriStr,oriStr);
    NSLog(@"-- strongStr = %@   p1 = %p  p2 = %p",strongStr,&strongStr,strongStr);
    NSLog(@"-- copiedStr = %@   p1 = %p  p2 = %p",copiedStr,&copiedStr,copiedStr);
    NSLog(@"-- muCopiedStr = %@ p1 = %p  p2 = %p",muCopiedStr,&muCopiedStr,muCopiedStr);
}

@end
