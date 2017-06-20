//
//  ManyIvar.h
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManyIvar : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *telNO;
@property (nonatomic, copy) NSString *schoolName;

@property (nonatomic, assign) BOOL hasMarried;
@property (nonatomic, assign) NSUInteger age;

//不用于归解档的属性
@property (nonatomic, copy) NSString *test;

@end
