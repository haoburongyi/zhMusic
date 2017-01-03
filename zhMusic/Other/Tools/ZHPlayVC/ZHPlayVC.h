//
//  ZHPlayVC.h
//  zhMusic
//
//  Created by 张淏 on 16/12/30.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZHPlayHeader.h"

@interface ZHPlayVC : UIViewController

@property (nonatomic, strong) NSArray<MPMediaItem *> *playList;
@property (nonatomic, strong) ZHPlayHeader *header;
@property (nonatomic, strong) MPMediaItem *currentSong;

- (void)setPlayList:(NSArray<MPMediaItem *> *)playList;
- (void)disMiss;
+ (instancetype)defaultVC;
@end
