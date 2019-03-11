//
//  ViewController.m
//  DragAndPlayDemo
//
//  Created by 王乾 on 2019/3/11.
//  Copyright © 2019 王乾. All rights reserved.
//

#import "ViewController.h"

#import <pop/POP.h>

#import "VideoPlayerView.h"

@interface ViewController ()<POPAnimationDelegate>

@property (nonatomic, strong) UIControl *dragView;
@property (nonatomic, strong) VideoPlayerView *playView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dragView];
    
    [self.playView reloadPlayView:@"https://cdn.changguwen.com/cms/media/2019215/e2d03283-9b4c-437c-912a-2b00e1cb76a1-1550225573354.mp4"];
}

- (void)touchDown:(UIControl *)sender {
    // 按下移除所有动画效果
    [sender.layer pop_removeAllAnimations];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // translationInView 是手指移动后，在相对坐标中的偏移量
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (UIGestureRecognizerStateEnded == recognizer.state) {
        
        //  手指在视图上移动的速度（x,y）, 正负也是代表方向。绝对值上|x| > |y| 水平移动， |y|>|x| 竖直移动
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        //   提供一个过阻尼效果(其实Spring是一种欠阻尼效果)，可以实现类似UIScrollView的滑动衰减效果
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        // key理解为一个独立的唯一标示
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation666"];
    }
}
#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim {
    
    // 判断一个CGRect是否包含在另一个CGRect里面
    // 判断两个结构体是否有交错.可以用CGRectIntersectsRect
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        
        // 类似弹簧一般的动画效果
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation666"];
    }
}
- (UIControl *)dragView {
    
    if (!_dragView) {
        _dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 160, 90)];
        _dragView.center = self.view.center;
        _dragView.backgroundColor = [UIColor blueColor];
        [_dragView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handlePan:)];
        [_dragView addGestureRecognizer:recognizer];
    }
    return _dragView;
}
- (VideoPlayerView *)playView {
    
    if (!_playView) {
        _playView = [[VideoPlayerView alloc] initWithFrame:CGRectZero superView:_dragView];
    }
    return _playView;
}
@end
