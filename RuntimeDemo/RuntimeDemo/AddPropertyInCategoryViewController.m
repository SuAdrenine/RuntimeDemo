//
//  AddPropertyInCategoryViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "AddPropertyInCategoryViewController.h"
#import "Man+AddAName.h"

@interface AddPropertyInCategoryViewController ()

@end

@implementation AddPropertyInCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;
    
    Man *m = [Man new];
    m.name = @"test_name";
    NSLog(@"这是在分类中新增的属性name的值-->%@",m.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
