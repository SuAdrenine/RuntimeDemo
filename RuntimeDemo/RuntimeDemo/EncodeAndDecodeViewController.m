//
//  EncodeAndDecodeViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "EncodeAndDecodeViewController.h"
#import "CongigManyIvar.h"
#import "ManyIvar.h"

@interface EncodeAndDecodeViewController ()

@end

@implementation EncodeAndDecodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;
    
    ManyIvar *m = [ManyIvar new];
    m.name = @"Tony";
    m.firstName = @"Smith";
    //    m.lastName = @"Tony";如果有一个属性没有值会不会crash呢，查看打印结果是encodeObject:(null) forKey:_lastName和setValue:(null) forKey:_lastName
    m.address = @"beijing";
    m.telNO = @"010-1234567";
    m.schoolName = @"北京大学";
    
    m.hasMarried = NO;
    m.age = 40;
    
    //不用于归解档的属性
    m.test = @"It's test property";
    
    [CongigManyIvar saveIvarModel:m];
    [CongigManyIvar myIvarModel];
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
