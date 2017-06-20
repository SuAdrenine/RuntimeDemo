//
//  CongigManyIvar.h
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManyIvar.h"

@interface CongigManyIvar : NSObject

@property (nonatomic, strong) ManyIvar *myIvarModel;

+ (ManyIvar *)myIvarModel ;
+ (void)saveIvarModel:(ManyIvar *)model;

@end
