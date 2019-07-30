//
//  TKBaseNavigationController.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "TKBaseNavigationController.h"
#import "TKBaseViewController.h"
//#import "UIImage+UtopaAdd.h"
#import "UIColor+Add.h"
#import "UIImage+YYAdd.h"

@interface TKBaseNavigationController ()

@end

@implementation TKBaseNavigationController

+ (void)initialize {
    //设置通用navBar 样式
    
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"],NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    //设置标题的字体大小  和 字体颜色 所在导航栏 背景色 透明
    [UINavigationBar appearance].translucent = NO;
    // 修改 导航栏线的 颜色
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIImage *colorImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(screenWidth, 0.5)];
    [[UINavigationBar appearance] setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"eeeeee"] size:CGSizeMake(screenWidth, 0.5)]];
    
}

//初始化
- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 解决    苹果设备左右滑动手势在自定义返回按钮失效 的解决方法
 */
- (void)setup {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        //        NSLog(@"设置侧滑成功")
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak TKBaseNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //        NSLog(@"delegate 设置成功");
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf; //注意这个设置代理要在这里设置 在init中设置会导致无法调用代理方法
    }
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        [viewController.navigationController setNavigationBarHidden:YES animated:animated];
    }
    
    if ([viewController isKindOfClass:[TKBaseViewController class]]) {
        TKBaseViewController * vc = (TKBaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
    
//    if ([viewController isKindOfClass:[UtopaBaseWMPageController class]]) {
//        UtopaBaseWMPageController * vc = (UtopaBaseWMPageController *)viewController;
//        if (vc.isHidenNaviBar) {
//            [vc.navigationController setNavigationBarHidden:YES animated:animated];
//        } else {
//            [vc.navigationController setNavigationBarHidden:NO animated:animated];
//        }
//    }
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES; //隐藏底部tabbar
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        [super pushViewController:viewController animated:animated];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//     if ([self.baseCurrentShowVC respondsToSelector:@selector(viewCanSwipGestureBack)]) {
//        return [self.baseCurrentShowVC viewCanSwipGestureBack];
//     }
//     if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        return (self.baseCurrentShowVC == self.topViewController);
//     }
    NSLog(@"gestureRecognizerShouldBegin");
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
