//
//  RootViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/16.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property(nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *titleArr = @[@"获取属性、成员变量与方法",@"获取协议列表以及方法交换",@"在分类中增加属性",@"获取类中所有成员变量以及归解档",@"字典转模型",@"探索selector找到对应的IMP地址",@"Others Demo"];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [self.buttonArr addObject:button];
        button.tag = 1001+i;
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(turnToNextPage:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.buttonArr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                                withFixedSpacing:20 leadSpacing:100 tailSpacing:50];
    
    [self.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)turnToNextPage:(UIButton *)button {
    NSUInteger index = button.tag -1001;
    // 类名，标题
    NSArray *userInfo = @[@{@"class": @"GetClassAndMethodViewController",
                            @"property":
                                @{@"myTitle": @"获取属性、成员变量与方法"}
                            },
                          @{@"class": @"ExchangeMethodViewController",
                            @"property":
                                @{@"myTitle": @"获取协议列表以及方法交换"}
                            },
                          @{@"class": @"AddPropertyInCategoryViewController",
                            @"property":
                                @{@"myTitle": @"在分类中增加属性"}
                            },
                          @{@"class": @"EncodeAndDecodeViewController",
                            @"property":
                                @{@"myTitle": @"在分类中增加属性"}
                            },
                          @{@"class": @"ExchangeDicAndModelViewController",
                            @"property":
                                @{@"myTitle": @"字典转模型"}
                            },
                          @{@"class": @"FindIMPBySelectorViewController",
                            @"property":
                                @{@"myTitle": @"探索selector找到对应的IMP地址"}
                            },
                          @{@"class": @"OthersDemoViewController",
                            @"property":
                                @{@"myTitle": @"Others Demo"}
                            }];
        [self push:userInfo[index]];
    
}

/**
 跳转界面

 @param params <#params description#>
 */
- (void)push:(NSDictionary *)params
{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
    // 获取导航控制器
//    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器
//    [pushClassStance pushViewController:instance animated:YES];
    [self.navigationController pushViewController:instance animated:YES];
}


/**
 检测对象是否存在该属性

 @param instance <#instance description#>
 @param verifyPropertyName <#verifyPropertyName description#>
 @return <#return value description#>
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

-(NSMutableArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = @[].mutableCopy;
    }
    
    return _buttonArr;
}

@end
