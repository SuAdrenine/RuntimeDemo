//
//  People.h
//  RuntimeDemo
//
//  Created by xby on 2017/6/16.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeopleDelegate <NSObject>

-(void)peopleDelegateMethod;

@end

@interface People : NSObject {
    NSUInteger age_ivar;
    NSString *_name_ivar;
}

@property (nonatomic, strong) NSString *name_pro;
@property (nonatomic, assign) NSUInteger age_pro;

/**
 实例方法与类方法
 */
-(void)insMeth_PrintName;
+(void)clasMeth_PrintName;

/**
 用于测试method_exchangeImplementations的实例方法与类方法
 */
-(void)exchange_ins_method;
+(void)exchange_class_method;


/**
 用于在分类中被替换实现
 */
+(void)usetoReplace_method;

@end
