//
//  NSObject+JCS_DeepCopy.h
//  CopyTest2
//
//  Created by 永平 on 2019/3/29.
//  Copyright © 2019 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JCS_DeepCopy)

- (id)jcs_deepCopy;

@end

NS_ASSUME_NONNULL_END
