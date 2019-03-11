//
//  VideoPlayerView.h
//  DragAndPlayDemo
//
//  Created by 王乾 on 2019/3/11.
//  Copyright © 2019 王乾. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayerViewDelegate <NSObject>

@optional

@end

@interface VideoPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView *)superView;

- (void)reloadPlayView:(NSString *)urlString;

@end
