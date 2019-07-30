//
//  MovieItemCell.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "MovieItemCell.h"

@implementation MovieItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    // Initialization code
}

@end
