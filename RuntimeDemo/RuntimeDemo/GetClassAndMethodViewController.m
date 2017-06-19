//
//  GetClassAndMethodViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/16.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "GetClassAndMethodViewController.h"
#import "People.h"

@interface GetClassAndMethodViewController ()

@property(nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation GetClassAndMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;
    self.buttonArr = @[].mutableCopy;
    
    NSArray *titleArr = @[@"runtime获取属性列表",@"runtime获取成员变量列表",@"runtime获取实例方法列表",@"runtime获取类方法列表",@"runtime获取实例方法",@"runtime获取类方法"];
    NSArray *selArr = @[@"getPropertyList",@"getIvarList",@"getMethodList",@"getClassMethodList",@"getInstanceMethod",@"getClassMethod"];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [self.buttonArr addObject:button];
        button.tag = 1001+i;
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        [button addTarget:self action:NSSelectorFromString(selArr[i]) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.buttonArr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                                withFixedSpacing:50 leadSpacing:100 tailSpacing:100];
    
    [self.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];

}

/**
 获取属性列表，不会输出成员变量
 */
-(void)getPropertyList {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([People class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"Property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
}

/**
 获取方法（不包括类方法）列表
 */
-(void)getMethodList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([People class], &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"Method---->%@", NSStringFromSelector(method_getName(method)));
    }
}

/**
 获取类方法列表
 */
-(void)getClassMethodList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(NSClassFromString(@"People")), &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"Method---->%@", NSStringFromSelector(method_getName(method)));
    }
}

/**
 获取成员列表
 */
-(void)getIvarList{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([People class], &count);
    for (unsigned int i=0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
}

/**
 获取实例方法
 */
-(void)getInstanceMethod {
    People * p = [[People alloc] init];
    
    Method m = class_getInstanceMethod([p class], @selector(insMeth_Print));
    
}

/**
 获取类方法
 */
-(void)getClassMethod {
    Method m = class_getClassMethod([People class], @selector(classMeth_Print));
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
