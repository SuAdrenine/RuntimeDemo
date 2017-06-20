//
//  CongigManyIvar.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "CongigManyIvar.h"

@implementation CongigManyIvar

static NSString *kConfigureManyIvarModel = @"kConfigureAccountModel";

+ (ManyIvar *)myIvarModel {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigureManyIvarModel];
    id ret = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!ret) {
        ret = [ManyIvar new];
    }
    return  ret;
}

+ (void)saveIvarModel:(ManyIvar *)model {
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:kConfigureManyIvarModel];
}

@end
