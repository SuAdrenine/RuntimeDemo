//
//  NSObject+EncodeAndDecode.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "NSObject+EncodeAndDecode.h"
#import <objc/runtime.h>

@implementation NSObject (EncodeAndDecode)

-(void)decode:(NSCoder *)aDecoder {
    NSLog(@"正在解档，请稍候...");
    //一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i =0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {
                    continue;
                }
            }
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
            NSLog(@"setValue:%@ forKey:%@",value,key);
        }
        free(ivars);
        c = [c superclass];
    }
}

-(void)encode:(NSCoder *)aCoder {
    NSLog(@"正在归档，请稍候...");
    //一层层往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现改方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {
                    continue;
                }
            }
            //利用KVC取值
            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
            NSLog(@"encodeObject:%@ forKey:%@",value,key);
        }
        
        free(ivars);
        c = [c superclass];
    }
}

@end
