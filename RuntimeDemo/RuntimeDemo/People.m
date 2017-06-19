//
//  People.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/16.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "People.h"

@interface People() {
    NSUInteger age_ivar_m;
    NSString *_name_ivar_m;
}

@property (nonatomic, strong) NSString *name_pro_m;
@property (nonatomic, assign) NSInteger age_pro_m;

@end

@implementation People

-(void)insMeth_Print {
    NSLog(@"实例方法:insMeth_Print");
}

+(void)classMeth_Print {
    NSLog(@"类方法:classMeth_Print");
}

-(void)exchange_ins_method {
    NSLog(@"实例方法:exchange_ins_method");
}

+(void)exchange_class_method{
    NSLog(@"类方法:exchange_class_method");
}

+(void)usetoReplace_method {
    NSLog(@"原始方法：usetoReplace_method");
}
@end
