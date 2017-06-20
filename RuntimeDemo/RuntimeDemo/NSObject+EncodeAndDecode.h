//
//  NSObject+EncodeAndDecode.h
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EncodeAndDecode)

- (NSArray *)ignoredNames;
- (void)encode:(NSCoder *)aCoder;
- (void)decode:(NSCoder *)aDecoder;

@end
