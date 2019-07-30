//
//  UIColor+Add.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "UIColor+Add.h"

@implementation UIColor (Add)
+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

///支持  # 0x 0X 或者无前缀开头的  RGB ARGB RRGGBB AARRGGBB 颜色格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    //如果处理完 字符串不为6，表面输入错误
    if (cString.length != 3 && cString.length != 4 && cString.length != 6 && cString.length != 8) {
        NSLog(@"colorWithHexString is wrong！");
        return [UIColor clearColor];
    }
    
    if (cString.length == 4) { //AGRB
        // Scan values
        unsigned int a;
        NSString *alpStr = [cString substringWithRange:NSMakeRange(0, 1)];
        // NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。
        [[NSScanner scannerWithString:alpStr] scanHexInt:&a];
        alpha = a / 16.0f;
        cString = [cString substringFromIndex:1];
    } else if (cString.length == 8) { //AARRGGBB
        // Scan values
        unsigned int a;
        NSString *alpStr = [cString substringWithRange:NSMakeRange(0, 2)];
        // NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。
        [[NSScanner scannerWithString:alpStr] scanHexInt:&a];
        alpha = a / 255.0f;
        cString = [cString substringFromIndex:2];
    }
    
    NSRange rangeR,rangeG,rangeB;
    if (cString.length == 3) {   // RGB -> RRGGBB
        NSString *r = [cString substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [cString substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [cString substringWithRange:NSMakeRange(2, 1)];
        cString = [NSString stringWithFormat:@"%@%@%@%@%@%@",r,r,g,g,b,b];
    }
    if (cString.length == 6) {
        rangeR.location = 0;
        rangeR.length = 2;
        rangeG.location = 2;
        rangeG.length = 2;
        rangeB.location = 4;
        rangeB.length = 2;
    } else {
        NSLog(@"colorWithHexString is wrong！");
        return [UIColor clearColor];
    }
    
    NSString *rString = [cString substringWithRange:rangeR];
    NSString *gString = [cString substringWithRange:rangeG];
    NSString *bString = [cString substringWithRange:rangeB];
    
    // Scan values
    unsigned int r, g, b;
    // NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat)r / 255.0f) green:((CGFloat)g / 255.0f) blue:((CGFloat)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWith8HexString:(NSString *)colorStr {
    return [self colorWithHexString:colorStr alpha:1.0f];;
}

+ (NSString *)colorHexString {
    UIColor *selfColor = self;
    if (CGColorGetNumberOfComponents(selfColor.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(selfColor.CGColor);
        selfColor = [UIColor colorWithRed:components[0]
                                    green:components[0]
                                     blue:components[0]
                                    alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(selfColor.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(selfColor.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(selfColor.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(selfColor.CGColor))[2]*255.0)];
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
