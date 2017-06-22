//
//  FindIMPBySelectorViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/22.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "FindIMPBySelectorViewController.h"
#import <objc/runtime.h>

#pragma mark - Tips
/**
 IMP class_getMethodImplementation(Class cls, SEL name);
 通过该传入的参数不同，找到不同的方法列表，方法列表中保存着下面方法的结构体，结构体中包含这方法的实现，selector本质就是方法的名称，通过该方法名称，即可在结构体中找到相应的实现。
 对于这种方法而言，类方法和实例方法实际上都是通过调用class_getMethodImplementation()来寻找IMP地址的，不同之处在于传入的第一个参数不同

 IMP method_getImplementation(Method m)
 传入的参数只有method，区分类方法和实例方法在于封装method的函数
 
 
 最后调用IMP method_getImplementation(Method m) 获取IMP地址
 

 */

/**
 在调用class_getMethodImplementation()方法时，无法找到对应实现时返回的相同的一个地址，无论该方法是在实例方法或类方法，无论是否对一个实例调用该方法，返回的地址都是相同的，但是每次运行该程序时返回的地址并不相同，而对于另一种方法，如果找不到对应的实现，则返回0，在图中我做了蓝色标记。
 
 还有一点有趣的是class_getClassMethod()的第一个参数无论传入objc_getClass()还是objc_getMetaClass()，最终调用method_getImplementation()都可以成功的找到类方法的实现。
 而class_getInstanceMethod()的第一个参数如果传入objc_getMetaClass()，再调用method_getImplementation()时无法找到实例方法的实现却可以找到类方法的实现。
 */

@interface Test : NSObject

-(void)test1;
+(void)test2;

@end

@implementation Test
-(instancetype)init {
    if (self = [super init]) {
        [self getIMPFromSelector:@selector(aaa)];   //调用不存在的方法
        [self getIMPFromSelector:@selector(test1)];//调用实例方法
        [self getIMPFromSelector:@selector(test2)];//调用类方法
    }
    
    return self;
}

-(void)test1 {
    NSLog(@"test1");
}

+(void)test2 {
    
}

-(void)getIMPFromSelector:(SEL)aSelector {
    //First Method
    IMP instanceIMP1 = class_getMethodImplementation(objc_getClass("Test"), aSelector);
    IMP classIMP1 = class_getMethodImplementation(objc_getMetaClass("Test"), aSelector);
    
    //Second Method
    Method instanceMethod = class_getInstanceMethod(objc_getClass("Test"), aSelector);
    IMP instanceIMP2 = method_getImplementation(instanceMethod);
    
    Method classMethod1 = class_getClassMethod(objc_getClass("Test"), aSelector);
    IMP classIMP2 = method_getImplementation(classMethod1);
    
    
    Method classMethod2 = class_getClassMethod(objc_getMetaClass("Test"), aSelector);
    IMP classIMP3 = method_getImplementation(classMethod2);
    
    NSLog(@"instanceIMP1:%p instanceIMP2:%p classIMP1:%p classIMP2:%p classIMP3:%p",instanceIMP1,instanceIMP2,classIMP1,classIMP2,classIMP3);
}

@end

@interface FindIMPBySelectorViewController ()

@property(nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation FindIMPBySelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonArr = @[].mutableCopy;
    self.title = self.myTitle;

    // Do any additional setup after loading the view.
    NSArray *titleArr = @[@"通过使用各种方法来查看",@"使用实例方法简单调用",@"使用类方法简单调用"];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [self.buttonArr addObject:button];
        button.tag = 1001+i;
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.buttonArr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                                withFixedSpacing:50 leadSpacing:200 tailSpacing:200];
    
    [self.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];
}

-(void)clickAction:(UIButton *)button {
    NSInteger tag = button.tag;
    switch (tag) {
        case 1001: {
            Test *test1 = [[Test alloc] init];
        }
            break;
        case 1002: {
            /*
             - (IMP)methodForSelector:(SEL)aSelector参数aSelector即使是私有方法，即在.h文件中没有暴露接口也会调用成功
             */
            IMP imp = [self methodForSelector:@selector(sayHi)];
            imp();
        }
            break;
            
        case 1003:{
            /*
            + (IMP)instanceMethodForSelector:(SEL)aSelector
            这个方法是个类方法，返回的是该方法(aSelector)的真正的函数地址
            */
            IMP imp = [FindIMPBySelectorViewController instanceMethodForSelector:@selector(sayGoodbye)];
            imp();
        }
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sayHi {
    NSLog(@"sayHi to little kitty");
}

-(void)sayGoodbye {
    NSLog(@"sayGoodbye to little kitty");
}

@end
