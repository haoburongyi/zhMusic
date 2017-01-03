//
//  ZHPlayHeader.h
//  zhMusic
//
//  Created by 张淏 on 17/1/1.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZHPlayHeader : UIView
@property (nonatomic, strong) UIImageView *artworkImageVIew;
@property (nonatomic, strong) MPMediaItem *currentSong;

+ (instancetype)playHeaderWithFrame:(CGRect)frame;
@end
