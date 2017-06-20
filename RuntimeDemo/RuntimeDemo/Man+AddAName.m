//
//  Man+AddAName.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "Man+AddAName.h"
#import <objc/runtime.h>

@implementation Man (AddAName)

char *keyName;

-(void)setName:(NSString *)name {
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &keyName, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name {
    return objc_getAssociatedObject(self, &keyName);
}

@end
