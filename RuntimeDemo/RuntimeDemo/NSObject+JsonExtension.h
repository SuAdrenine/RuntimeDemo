//
//  NSObject+JsonExtension.h
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsonExtension)

- (void)setDict:(NSDictionary *)dict;
+ (instancetype )objectWithDict:(NSDictionary *)dict;
// 告诉数组中都是什么类型的模型对象
- (NSString *)arrayObjectClass;

@end
