//
//  CDMacroDefine.h
//  CDCountdownTimerLabel
//
//  Created by cqz on 2019/3/7.
//  Copyright © 2019 ChangDao. All rights reserved.
//

#ifndef CDMacroDefine_h
#define CDMacroDefine_h



/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif




/*************************************************************************************************************************/


#define IS_IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

#define __MAIN_SCREEN_HEIGHT__      MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define __MAIN_SCREEN_WIDTH__       MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define __MAIN_SCREEN_BOUNDS__      [[UIScreen mainScreen] bounds]

#define  CDSCALE_W                 (IS_IPHONE ? (__MAIN_SCREEN_WIDTH__ / 375.0) : (__MAIN_SCREEN_WIDTH__ / 768.0))
#define  CDSCALE_H                 (IS_IPHONE ? (__MAIN_SCREEN_WIDTH__ / 375.0) : (__MAIN_SCREEN_HEIGHT__ / 1024.0))

#define  CDREALVALUE_WIDTH(w)      (CDSCALE_W * w)
#define  CDREALVALUE_HEIGHT(h)     (CDSCALE_H * h)

#define TextLine_Space  CDREALVALUE_WIDTH(5)

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

#define CD_IS_IPHONE_X ((IOS_VERSION >= 11.f) && IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

// iPhone X 系类安全区域适配
#define SafeAreaTopHeight (CD_IS_IPHONE_X ? 88 : 64)
#define SafeAreaBottomHeight (CD_IS_IPHONE_X ? 34 : 0)
#define SafeAreaStatusHeight (CD_IS_IPHONE_X ? 24 : 0)

#endif /* CDMacroDefine_h */
