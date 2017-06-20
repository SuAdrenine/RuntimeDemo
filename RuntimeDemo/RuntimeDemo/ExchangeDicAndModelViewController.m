//
//  ExchangeDicAndModelViewController.m
//  RuntimeDemo
//
//  Created by xby on 2017/6/20.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "ExchangeDicAndModelViewController.h"
#import "User.h"
#import "Book.h"
#import "NSObject+JsonExtension.h"

@interface ExchangeDicAndModelViewController ()

@end

@implementation ExchangeDicAndModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    User *user = [User objectWithDict:json];
    NSLog(@"%@",user.cat);
    for (Book *book in user.books) {
        NSLog(@"%@",book.name);
    }
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
