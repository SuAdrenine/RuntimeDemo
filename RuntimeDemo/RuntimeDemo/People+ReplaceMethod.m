//
//  People+ReplaceMethod.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/19.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "People+ReplaceMethod.h"
#import <objc/runtime.h>

@implementation People (ReplaceMethod)

+(void)load {
    NSString *className = NSStringFromClass(self.class);
//    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //要特别注意你替换的方法到底是哪个性质的方法
        // When swizzling a Instance method, use the following:
        //        Class class = [self class];
        
        // When swizzling a class method, use the following:
        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(usetoReplace_method);
        SEL swizzledSelector = @selector(real_usetoReplace_method);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

/**
 用于替换原始的usetoReplace_method实现
 */
+(void)real_usetoReplace_method {
    NSLog(@"分类中用来替换usetoReplace_method方法的实现");
    
    [self real_usetoReplace_method];    //因为方法替换，所以这里相当于调用[self usetoReplace_method]
}

@end
