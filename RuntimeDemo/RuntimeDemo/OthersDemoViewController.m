//
//  OthersDemoViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/22.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "OthersDemoViewController.h"
#import "TestRuntime.h"
#import <objc/message.h>
#import "NSObject+WHRuntime.h"
#import "UIImage+swizzlingImage.h"

@interface OthersDemoViewController ()

@property(nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation OthersDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonArr = @[].mutableCopy;
    self.title = self.myTitle;
    
    // Do any additional setup after loading the view.
    NSArray *titleArr = @[@"属性列表",@"成员变量列表",@"实例方法列表",@"类方法列表",@"协议列表",@"测试方法交换",@"添加方法",@"调用私有方法",@"给分类添加属性"];
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
                                withFixedSpacing:10 leadSpacing:100 tailSpacing:50];
    
    [self.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickAction:(UIButton *)button {
    NSInteger tag = [button tag];
    
    switch (tag) {
        case 1001: {
            /** 属性列表 */
            [self properties];

        }
            break;
        case 1002: {
            /** 成员变量列表 */
            [self ivar];
            
        }
            break;
        case 1003: {
            /** 实例方法列表 */
            [self instanceMethod];
            
        }
            break;
        case 1004: {
            /** 类方法列表 */
            [self classMethod];
            
        }
            break;
        case 1005: {
            /** 协议列表 */
            [self protocol];
            
        }
            break;
        case 1006: {
            /** 添加方法 */
            [self addMethod];
            
        }
            break;
        case 1007: {
            /** 调用私有方法 */
            [self privateMethod];
 
        }
            break;
        case 1008: {
            /** 给分类添加属性 */
            [self categoryProperty];
            
        }
            break;
        default:
            break;
    }
}

- (void)properties {
    NSLog(@"==================属性========================\n\n\n");
    NSLog(@"属性列表%@\n\n\n",[TestRuntime propertiesInfo]);
    NSLog(@"格式化了的属性列表%@\n\n\n",[TestRuntime propertiesWithCodeFormat]);
}


- (void)ivar {
    NSLog(@"=================成员变量=======================\n\n\n");
    NSLog(@"成员变量列表%@\n\n\n",[TestRuntime ivarInfo]);
}


- (void)instanceMethod {
    NSLog(@"==================实例方法======================\n\n\n");
    NSLog(@"实例方法列表%@\n\n\n",[TestRuntime instanceMethodList]);
}


- (void)classMethod {
    NSLog(@"==================类方法========================\n\n\n");
    NSLog(@"类方法列表%@\n\n\n",[TestRuntime classMethodList]);
}


- (void)protocol {
    NSLog(@"===================协议=========================\n\n\n");
    NSLog(@"协议列表%@\n\n\n",[TestRuntime protocolList]);
}


- (void)swizzlingMethod {
    NSLog(@"==================方法交换=========================\n\n\n");
    
    /**
     * 本地并没有叫做@"anyPicture"的图片
     * 不过由于在UIImage+swizzlingImage.m中运用runtime进行了方法交换
     * 在交换的方法中安排了占位图片
     * 所有会有一张图片显示
     *
     * 应用情景:从网络加载的图片失败，就显示占位图片.并且还是直接用imageNamed:
     */
    UIImage *image = [UIImage imageNamed:@"anyPicture"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}


- (void)addMethod {
    NSLog(@"=============找不到方法====添加方法==================\n\n\n");
    
    /**
     * 接收到未知的消息时，
     * 首先会调用所属类的类方法+resolveInstanceMethod:(实例方法)或+resolveClassMethod:(类方法)
     * 添加的方法在TestRuntime类的resolveInstanceMethod中
     */
    
    // 1.如果方法名是wh_addMethod，就添加一个MethodOne方法来执行
    TestRuntime *test1 = [[TestRuntime alloc] init];
    [test1 performSelector:@selector(wh_addMethod)];
    
    // 2.如果找不到方法，就添加一个addMethod来执行
    id test2 = [[TestRuntime alloc] init];
    [test2 length];
}


- (void)privateMethod {
    NSLog(@"=================调用私有方法=====================\n\n\n");
    TestRuntime *test = [[TestRuntime alloc] init];
//    objc_msgSend(test, @selector(privateMethod)); //Enable Strict Checking of objc_msgSend Calls  改为 NO，但是与前面imp()不兼容，所以运行时需注意切换
}


- (void)categoryProperty {
    NSLog(@"===============给分类添加属性=====================\n\n\n");
    UIImage *image = [[UIImage alloc] init];
    image.categoryProperty = @"运用runtime给分类添加属性,使UIimage有了一个字符串属性\n\n\n";
    NSLog(@"%@",image.categoryProperty);
}

@end
