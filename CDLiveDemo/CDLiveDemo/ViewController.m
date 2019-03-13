//
//  ViewController.m
//  CDLiveDemo
//
//  Created by 吴文海 on 2019/3/12.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "ViewController.h"

#import "CDLiveViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 40);
    [btn setTitle:@"推流" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(tuiliu:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)tuiliu:(UIButton *)btn {
    CDLiveViewController *liveVc = [[CDLiveViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:liveVc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
