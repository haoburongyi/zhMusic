//
//  ZHPlayVC.h
//  zhMusic
//
//  Created by 张淏 on 16/12/30.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZHPlayVC : UIViewController

@property (nonatomic, strong) NSArray<MPMediaItem *> *playList;

- (void)setPlayList:(NSArray<MPMediaItem *> *)playList;
+ (instancetype)defaultVC;
@end
