//
//  TKBaseViewController.h
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BaseNavButton:UIButton
@property (nonatomic) UIEdgeInsets alignmentRectInsetsOverride;
@end

@interface TKBaseViewController : UIViewController
///是否显示导航栏 默认 显示
@property (nonatomic, assign) BOOL isHidenNaviBar;

/// 返回按钮的图片,默认为[UtopaAppConfigModel sharedSingleton].naviBackImgName
@property (nonatomic, copy) NSString *backImageName;

/// 移除默认的返回按钮
- (void)hideBackButton;

/**
 默认返回上级 （子控制器可以重写实现特殊需求）
 */
- (void)backButtonDidClick;

/**
 控制器可以 手动控制返回
 @return 返回一个BOOL 值
 */
- (BOOL)viewCanSwipGestureBack;
@end

NS_ASSUME_NONNULL_END
