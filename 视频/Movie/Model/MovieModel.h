//
//  MovieModel.h
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *coverUrlStr;
@property (nonatomic, copy) NSString *tagStr;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, copy) NSString *showUrl;
@property (nonatomic, copy) NSString *descStr;
@end

NS_ASSUME_NONNULL_END
