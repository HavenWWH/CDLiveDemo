//
//  ViewController.m
//  CoursewareDownload
//
//  Created by cqz on 2019/3/8.
//  Copyright © 2019 ChangDao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.view addSubview:self.titleLabel];
}

#pragma mark - Intial Methods


#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Method

#pragma mark - External Delegate

#pragma mark - Setter Getter Methods
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width - 30, 50)];
        _titleLabel.font = [UIFont fontWithName:@"XIMANJW" size:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"喜满体的标题好有喜感";
    }
    return _titleLabel;
}

@end
