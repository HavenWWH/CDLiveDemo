//
//  VideoPlayerView.m
//  DragAndPlayDemo
//
//  Created by 王乾 on 2019/3/11.
//  Copyright © 2019 王乾. All rights reserved.
//

#import "VideoPlayerView.h"

#import <AliyunVodPlayerSDK/AliyunVodPlayerSDK.h>
#import <Masonry.h>

@interface VideoPlayerView ()<AliyunVodPlayerDelegate>

@property (nonatomic, weak) id <VideoPlayerViewDelegate>delegate;

@property (nonatomic, strong)   AliyunVodPlayer           *aliPlayer;
@property (nonatomic, strong)   UIView                    *aliPlayerView; // 阿里云播放view
@property (nonatomic, weak)     UIView                    *superView; // 父view
@property (nonatomic, strong)   NSURL                     *videoURL;

@end

@implementation VideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView *)superView {
    
    if (self = [super initWithFrame:frame]) {
        
        _superView = superView;
        [self setupView];
    }
    return self;
}

#pragma mark - Intial Methods
- (void)setupView {
    
    // 展示视图
    [self addPlayerToFatherView:_superView];
    [self configAliyunPlayer];

}
// 配置播放器
- (void)configAliyunPlayer {
    
    self.backgroundColor = [UIColor blackColor];
    
    // 设置阿里云播放器
    self.aliPlayer.delegate = self;
    self.aliPlayerView = self.aliPlayer.playerView;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self insertSubview:self.aliPlayerView atIndex:0];
}
#pragma mark - Target Methods

#pragma mark - Public Methods
- (void)reloadPlayView:(NSString *)urlString {
    
    if (urlString.length > 0) {
        self.videoURL = [NSURL URLWithString:urlString];
    }
    [self.aliPlayer prepareWithURL:self.videoURL];
    [self.aliPlayer setAutoPlay:true];
    [self.aliPlayer start];

}
#pragma mark - AliyunVodPlayerDelegate
/**
 * 功能：播放事件协议方法,主要内容 AliyunVodPlayerEventPrepareDone状态下，此时获取到播放视频数据（时长、当前播放数据、视频宽高等）
 * 参数：event 视频事件
 */
- (void)vodPlayer:(AliyunVodPlayer *)vodPlayer onEventCallback:(AliyunVodPlayerEvent)event {
    
    switch (event) {
        case AliyunVodPlayerEventBeginLoading: {
            NSLog(@"视频loading时候触发");
            
            break;
        }
        case AliyunVodPlayerEventEndLoading: {
            NSLog(@"视频加载完成时触发");
            
            break;
        }
        case AliyunVodPlayerEventPrepareDone: {
            NSLog(@"播放准备完成时触发");
            break;
        }
        case AliyunVodPlayerEventPlay: {
            NSLog(@"暂停后恢复播放时触发");
            
            break;
        }
        case AliyunVodPlayerEventSeekDone: {
            NSLog(@"视频Seek完成时触发");
            
            break;
        }
        case AliyunVodPlayerEventPause: {
            NSLog(@"视频暂停时触发");
            break;
        }
        case AliyunVodPlayerEventStop: {
            NSLog(@"主动使用stop接口时触发");
            break;
        }
        case AliyunVodPlayerEventFinish: {
            NSLog(@"视频正常播放完成时触发");

            break;
        }
        case AliyunVodPlayerEventFirstFrame: {
            NSLog(@"播放视频首帧显示出来时触发");
            
            break;
        }
        default:
            break;
    }
}

/**
 * 功能：播放器播放时发生错误时，回调信息
 * 参数：errorModel 播放器报错时提供的错误信息对象
 */
- (void)vodPlayer:(AliyunVodPlayer *)vodPlayer playBackErrorModel:(AliyunPlayerVideoErrorModel *)errorModel {
    NSLog(@"播放器播放时发生错误时");
}
#pragma mark - Private Method
- (void)addPlayerToFatherView:(UIView *)view {
    // 添加判断，因为view有可能为空，当view为空时[view addSubview:self]会crash
    if (view) {
        
        [self removeFromSuperview];
        [view addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
}
#pragma mark - Setter Getter Methods
- (AliyunVodPlayer *)aliPlayer {
    if (!_aliPlayer) {
        _aliPlayer = [[AliyunVodPlayer alloc] init];
        //        _aliPlayer.delegate = self;
        _aliPlayer.quality = AliyunVodPlayerVideoHD;
        _aliPlayer.circlePlay = false;
        //        _aliPlayer.printLog = false;
        //         边播边下缓存功能
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        //maxsize MB    maxDuration 秒
        [_aliPlayer setPlayingCache:true saveDir:cachPath maxSize:3000 maxDuration:1000000];
    }
    return _aliPlayer;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.aliPlayerView.frame = self.bounds;
}

@end
