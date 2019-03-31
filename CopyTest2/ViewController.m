//
//  ViewController.m
//  CopyTest2
//
//  Created by 永平 on 2019/3/27.
//  Copyright © 2019 yongping. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[Test alloc] init] run];
}


@end
