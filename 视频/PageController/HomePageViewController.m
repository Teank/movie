//
//  HomePageViewController.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "HomePageViewController.h"
#import "ViewController.h"
#import "MovieListController.h"
#import "TKBaseNavigationController.h"
@interface HomePageViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark wmpageDelegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    MovieListController *vc = [[MovieListController alloc]init];
    switch (index) {
        case 0:
            {
                vc.type = 1 ;
            }
            break;
        case 1:
        {
            vc.type = 2 ;
        }
            break;
        case 2:
        {
            vc.type = 7 ;
        }
            break;
            
        default:
        {
            vc.type = 1 ;
        }
            break;
    }
//    TKBaseNavigationController *nav = [[TKBaseNavigationController alloc]initWithRootViewController:vc];
    vc.isHidenNaviBar = YES;
//    [vc setValue:self.navigationController forKey:@"navigationController"];// = self.navigationController;
    return vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"电影",@"电视剧",@"动漫"][index];
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 );
}

/**
 Implement this datasource method, in order to customize your own menuView's frame
 
 @param pageController The container controller
 @param menuView The menuView
 @return The frame of the menuView
 */
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,   50 );
}
 

@end
