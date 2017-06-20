//
//  ExchangeMethodViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/16.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "ExchangeMethodViewController.h"
#import "People.h"
#import "People+ReplaceMethod.h"

@interface ExchangeMethodViewController ()<PeopleDelegate,UITabBarDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation ExchangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;
    self.buttonArr = @[].mutableCopy;
    
    NSArray *titleArr = @[@"runtime获取协议列表",@"method_exchangeImplementations",@"class_addMethod和class_replaceMethod"];
    NSArray *selArr = @[@"getProtocalList",@"exchangeMethodImp",@"replaceMethod"];
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
                                withFixedSpacing:50 leadSpacing:150 tailSpacing:150];
    
    [self.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];

}

/**
 获取协议列表
 */
-(void)getProtocalList {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);  //这里变成了self
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

/**
 方法交换
 */
-(void)exchangeMethodImp {
    People * p = [[People alloc] init];
    
    Method m1 = class_getInstanceMethod([p class], @selector(exchange_ins_method));
    Method m2 = class_getClassMethod([People class], @selector(exchange_class_method));
    NSLog(@"测试前：");
    [p exchange_ins_method];
    [People exchange_class_method];
    
    method_exchangeImplementations(m1, m2);
    NSLog(@"测试后：");
    [p exchange_ins_method];
    [People exchange_class_method];
}

/**
 使用class_addMethod和class_replaceMethod交换方法
 */
-(void)replaceMethod {
    NSLog(@"这里调用的是原始方法，但是却会替换成分类里面的实现");
    [People usetoReplace_method];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
