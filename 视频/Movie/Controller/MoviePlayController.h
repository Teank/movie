//
//  MoviePlayController.h
//  视频
//
//  Created by Teank on 2019/7/30.
//  Copyright © 2019 tiank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MoviePlayController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *playerContentView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) MovieModel *movieModel;
@end

NS_ASSUME_NONNULL_END
