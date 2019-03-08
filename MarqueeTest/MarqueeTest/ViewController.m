//
//  ViewController.m
//  MarqueeTest
//
//  Created by 王乾 on 2019/3/8.
//  Copyright © 2019 王乾. All rights reserved.
//

#import "ViewController.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) QMUIMarqueeLabel *marqueeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.marqueeLabel];
    [self.marqueeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(150);
    }];
    
    self.marqueeLabel.speed = 1.5; // 调节滚动速度
    self.marqueeLabel.pauseDurationWhenMoveToEdge = 2.0; // 当文字第一次显示在界面上，以及重复滚动到开头时都要停顿一下，这个属性控制停顿的时长，默认为 2.5
    self.marqueeLabel.spacingBetweenHeadToTail = 15; // 用于控制首尾连接的文字之间的间距，默认为 40pt。
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *displayString = self.marqueeLabel.text;
    
    self.marqueeLabel.text = [displayString stringByAppendingString:@"王乾王乾王乾王乾王乾王乾王乾王乾"];
}
- (QMUIMarqueeLabel *)marqueeLabel {
    
    if (!_marqueeLabel) {
        _marqueeLabel = [[QMUIMarqueeLabel alloc] init];
        _marqueeLabel.text = @"你是事实你啊酸辣粉就舒服了科匠了解了房贷首付科匠科匠科匠科匠";
        _marqueeLabel.textColor = UIColorBlack;
        _marqueeLabel.font = [UIFont systemFontOfSize:15];
        _marqueeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _marqueeLabel;
}
@end
