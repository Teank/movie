//
//  UIColor+Add.h
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Add)
+ (UIColor *)colorWithHexString:(NSString *)color ;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWith8HexString:(NSString *)colorStr;

+ (NSString *)colorHexString;
+ (UIColor *)randomColor ;
@end

NS_ASSUME_NONNULL_END
