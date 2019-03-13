//
//  CDLiveViewController.m
//  CDLiveDemo
//
//  Created by 吴文海 on 2019/3/12.
//  Copyright © 2019 吴文海. All rights reserved.
//

#import "CDLiveViewController.h"

#import <AlivcLivePusher/AlivcLivePusherHeader.h>
#import <AlivcLibFace/AlivcLibFaceManager.h>
#import <ALivcLibBeauty/AlivcLibBeautyManager.h>


#define AlivcScreenWidth  [UIScreen mainScreen].bounds.size.width
#define AlivcScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface CDLiveViewController ()<AlivcLivePusherErrorDelegate, AlivcLivePusherInfoDelegate, AlivcLivePusherNetworkDelegate, AlivcLivePusherCustomFilterDelegate>
@property (nonatomic, strong) AlivcLivePushConfig *liveConfig;
@property (nonatomic, strong) AlivcLivePusher *livePusher;

@property (nonatomic, strong) NSString *pushLiveUrl;
@property (nonatomic, strong) UIView *previewView;
@end

@implementation CDLiveViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pushLiveUrl = @"rtmp://livepush.changguwen.com/changdao/21312312321?auth_key=1552462440-827aae06e05e4d1e9f555410f61c7640-0-82e72d1faf6f744cd2779776f57f42d3";
    
    [self initSubviews];
}
#pragma mark - Intial Methods
- (void)initSubviews {
  
    [self.view addSubview:self.previewView];

    int previewSuc = [self.livePusher startPreviewAsync:self.previewView];
    if (previewSuc != 0) {
        
        NSLog(@"预览失败");
        
    } else {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            int suce = [self.livePusher startPushWithURLAsync:self.pushLiveUrl];
            [self.livePusher setLogLevel:(AlivcLivePushLogLevelDebug)];
            if (suce != 0) {
                
                NSLog(@"推流失败");
            } else {
                
                
            }
        });
    }

    [self masLayoutSubViews];
}
- (void)masLayoutSubViews {
    
}

#pragma mark - Network Methods

#pragma mark - Target Methods

#pragma mark - Public Methods

#pragma mark - Private Method

#pragma mark - 相关代理 -
#pragma mark - AlivcLivePusherErrorDelegate 错误 -
/**
 系统错误回调
 */
- (void)onSystemError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error {
    
    NSLog(@"%@",error);
}

/**
 SDK错误回调
 */
- (void)onSDKError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error {
    
    NSLog(@"%@",error);
}


#pragma mark - AlivcLivePusherInfoDelegate 推流-
- (void)onPreviewStarted:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流预览开始0");
}

/**
 停止预览回调
 */
- (void)onPreviewStoped:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流停止预览");
}

/**
 渲染第一帧回调
 */
- (void)onFirstFramePreviewed:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流预览第一帧回调%@", @(pusher.getLiveStatus));
}


/**
 推流开始回调
 */
- (void)onPushStarted:(AlivcLivePusher *)pusher {
    
     NSLog(@"推流开始回调");
}

/**
 推流暂停回调
 */
- (void)onPushPaused:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流暂停回调");
}

/**
 推流恢复回调
 */
- (void)onPushResumed:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流恢复回调");
}

/**
 重新推流回调
 */
- (void)onPushRestart:(AlivcLivePusher *)pusher {
    
    NSLog(@"重新推流回调");
}

/**
 推流停止回调
 */
- (void)onPushStoped:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流停止回调");
}


#pragma mark - AlivcLivePusherNetworkDelegate 网络 -
/**
 网络差回调
 */
- (void)onNetworkPoor:(AlivcLivePusher *)pusher {
    
    NSLog(@"网络差回调");
}

/**
 推流链接失败
 */
- (void)onConnectFail:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error {
    
    NSLog(@"推流链接失败");
}

/**
 网络恢复
 */
- (void)onConnectRecovery:(AlivcLivePusher *)pusher {
    
    NSLog(@"网络恢复");
}

/**
 重连开始回调
 */
- (void)onReconnectStart:(AlivcLivePusher *)pusher {
   
    NSLog(@"重连开始回调");
}

/**
 重连成功回调
 */
- (void)onReconnectSuccess:(AlivcLivePusher *)pusher {
    
    NSLog(@"重连成功回调");
}

/**
 连接被断开
 */
- (void)onConnectionLost:(AlivcLivePusher *)pusher {
    NSLog(@"连接被断开");
}

/**
 重连失败回调
 */
- (void)onReconnectError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error {
    
    NSLog(@"重连失败回调");
}

/**
 发送数据超时
 */
- (void)onSendDataTimeout:(AlivcLivePusher *)pusher {
    
    NSLog(@"发送数据超时");
}

/**
 推流URL的鉴权时长即将过期(将在过期前1min内发送此回调)
 */
- (NSString *)onPushURLAuthenticationOverdue:(AlivcLivePusher *)pusher {
    
    NSLog(@"推流URL的鉴权时长即将过期将在过期前1min内发送此回调");
    if(!self.livePusher.isPushing) {
        
        NSLog(@"更新pushUrl");
    }
    return self.pushLiveUrl;
}

/**
 发送SEI Message 通知
 */
- (void)onSendSeiMessage:(AlivcLivePusher *)pusher {
    
    NSLog(@"发送SEI Message 通知");
}

/**
 网络原因导致音视频丢包
 */
- (void)onPacketsLost:(AlivcLivePusher *)pusher {
    
    NSLog(@"网络原因导致音视频丢包");
}

#pragma mark - AlivcLivePusherCustomFilterDelegate 滤镜 -
/**
 通知外置滤镜创建回调
 */
- (void)onCreate:(AlivcLivePusher *)pusher context:(void*)context {
    
    NSLog(@"通知外置滤镜创建回调");
    [[AlivcLibBeautyManager shareManager] create:context];
}

/**
 通知外置滤镜设置参数
 */
- (void)updateParam:(AlivcLivePusher *)pusher buffing:(float)buffing whiten:(float)whiten pink:(float)pink cheekpink:(float)cheekpink thinface:(float)thinface shortenface:(float)shortenface bigeye:(float)bigeye {
    
    NSLog(@"通知外置滤镜设置参数");
    [[AlivcLibBeautyManager shareManager] setParam:buffing whiten:whiten pink:pink cheekpink:cheekpink thinface:thinface shortenface:shortenface bigeye:bigeye];
}

/**
 通知外置滤镜开馆
 */
- (void)switchOn:(AlivcLivePusher *)pusher on:(bool)on {
    
    NSLog(@"通知外置滤镜开馆");
    [[AlivcLibBeautyManager shareManager] switchOn:on];
}
/**
 通知外置滤镜处理回调
 */
- (int)onProcess:(AlivcLivePusher *)pusher texture:(int)texture textureWidth:(int)width textureHeight:(int)height extra:(long)extra {
    
    NSLog(@"通知外置滤镜处理回调");
     return [[AlivcLibBeautyManager shareManager] process:texture width:width height:height extra:extra];
}

/**
 通知外置滤镜销毁回调
 */
- (void)onDestory:(AlivcLivePusher *)pusher {
    
    NSLog(@"通知外置滤镜销毁回调");
    [[AlivcLibBeautyManager shareManager] destroy];
}


#pragma mark - Setter Getter Methods
- (AlivcLivePushConfig *)liveConfig {
    if (!_liveConfig) {
        _liveConfig = [[AlivcLivePushConfig alloc] init];
        _liveConfig.resolution = AlivcLivePushResolution540P;
//         系统自适应, 帧率和码率降不能自定义
        _liveConfig.qualityMode = AlivcLivePushQualityModeResolutionFirst;
        
        _liveConfig.enableAutoBitrate = YES;
        _liveConfig.fps = 20;
        
        // 推流方向
        _liveConfig.orientation = AlivcLivePushOrientationPortrait;
        _liveConfig.cameraType = AlivcLivePushCameraTypeBack;
    }
    return _liveConfig;
}

- (AlivcLivePusher *)livePusher {
    if (!_livePusher) {
        _livePusher = [[AlivcLivePusher alloc] initWithConfig:self.liveConfig];
        // 推流错误回调
        [_livePusher setErrorDelegate:self];
        // 推流状态回调
        [_livePusher setInfoDelegate:self];
        // 推流网络回调
        [_livePusher setNetworkDelegate:self];
        // 自定义滤镜回调
        [_livePusher setCustomFilterDelegate:self];
//        // 自定义人脸识别回调
//        [_livePusher setCustomDetectorDelegate:self];
//        // 背景音乐监听回调
//        [_livePusher setBGMDelegate:self];
    }
    return _livePusher;
}
    
- (UIView *)previewView {
    if (!_previewView) {
        _previewView = [[UIView alloc] init];
        _previewView.backgroundColor = [UIColor whiteColor];
        _previewView.frame = CGRectMake(0, 0, AlivcScreenWidth, AlivcScreenHeight);
    }
    return _previewView;
}


#pragma mark - auth

@end
