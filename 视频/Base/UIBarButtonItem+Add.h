//
//  UIBarButtonItem+Add.h
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Add)

/**
 自定义UIBarButtonItem 图
 
 @param icon 普通状态  显示的  图片名
 @param hightlightIcon 高亮状态 显示的 图片名
 @param target 触发的事件的对象
 @param action 触发的事件（方法）
 @return 返回一个自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(UIImage *)icon highlightIcon:(UIImage *)hightlightIcon   target:(id)target action:(SEL)action ;


/**
 自定义UIBarButtonItem 文
 
 @param title 显示文字
 @param color 普通状态 文字颜色
 @param highlightedColor 高亮状态的 文字颜色
 @param target 触发的事件的对象
 @param action  触发的事件（方法）
 @return 返回一个自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
