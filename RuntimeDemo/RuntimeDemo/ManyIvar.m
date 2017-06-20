//
//  ManyIvar.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "ManyIvar.h"
#import "NSObject+EncodeAndDecode.h"

@implementation ManyIvar

// 设置需要忽略的属性
- (NSArray *)ignoredNames {
    return @[@"_test"];
}

// 在系统方法内来调用我们的方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self encode:aCoder];
}

@end
