//
//  ViewController.m
//  CDCountdownTimerLabel
//
//  Created by cqz on 2019/3/7.
//  Copyright © 2019 ChangDao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MZTimerLabelDelegate>


@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) MZTimerLabel *timerLabel;

@end

@implementation ViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.view addSubview:self.countdownLabel];
    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_offset(SafeAreaTopHeight + CDREALVALUE_HEIGHT(50));
        make.left.equalTo(self.view).offset(CDREALVALUE_WIDTH(15.0));
        make.right.equalTo(self.view).offset(CDREALVALUE_WIDTH(-15.0));
        make.height.mas_offset(CDREALVALUE_HEIGHT(100));
    }];
    
    NSTimeInterval timerInterval = 60 * 60 * 24 + 70;
    NSTimeInterval numInterval = [NSDate date].timeIntervalSince1970 + timerInterval;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:numInterval];
    
    [self.timerLabel setCountDownToDate:date];
    [self.timerLabel start];
}

#pragma mark - Intial Methods


#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Method

#pragma mark - External Delegate

//MARK:- MZTimerLabelDelegate
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime {
    
    NSLog(@"直播开始了");
}
-(void)timerLabel:(MZTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType {
    
}
-(NSString*)timerLabel:(MZTimerLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time {
    
    if (time >= 86400) {
        
        int second = (int)time  % 60;
        int minute = ((int)time / 60) % 60;
        int hours = time / 3600;
        int days = time / 86400;
        return [NSString stringWithFormat:@"%02d天 %02d小时 %02d分钟 %02ds",days, hours,minute,second];
    }
    
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int hours = time / 3600;
    return [NSString stringWithFormat:@"%02d小时 %02d分钟 %02ds",hours,minute,second];
}


#pragma mark - Setter Getter Methods
- (UILabel *)countdownLabel {
    if (!_countdownLabel) {
        _countdownLabel = [[UILabel alloc] init];
        _countdownLabel.font = [UIFont systemFontOfSize:20];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        _countdownLabel.textColor = [UIColor redColor];
    }
    return _countdownLabel;
}
- (MZTimerLabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[MZTimerLabel alloc] initWithLabel:self.countdownLabel andTimerType:MZTimerLabelTypeTimer];
        _timerLabel.delegate = self;
//        _timerLabel.timeFormat = @"mm:ss";
//        _timerLabel.endedBlock = ^(NSTimeInterval) {
//
//        }
    }
    return _timerLabel;
}
@end
