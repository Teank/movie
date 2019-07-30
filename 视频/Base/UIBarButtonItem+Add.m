//
//  UIBarButtonItem+Add.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "UIBarButtonItem+Add.h"

@implementation UIBarButtonItem (Add)
+ (UIBarButtonItem *)itemWithIcon:(UIImage *)icon highlightIcon:(UIImage *)hightlightIcon target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:icon forState:UIControlStateNormal];
    [button setBackgroundImage:hightlightIcon forState:UIControlStateHighlighted];
    button.frame  = (CGRect){CGPointZero, button.currentImage.size}; //起始点左边，长宽
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame  = (CGRect){CGPointZero, 40, 30};
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [button setTitleColor:highlightedColor forState:UIControlStateDisabled];
    
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
    
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
