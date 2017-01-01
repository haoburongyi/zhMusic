//
//  ZHPlayMusicManager.h
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHPlayMusicManager : NSObject

@property (nonatomic, assign, getter=isPlaying, readonly) BOOL playing;

/**
 单例

 @return instance
 */
+ (instancetype)defaultManager;

/**
 当前时间
 */
@property (nonatomic,assign) NSTimeInterval currentTime;

/**
 总时间
 */
@property (nonatomic,assign) NSTimeInterval duration;

/**
 播放歌曲

 @param songUrl 歌曲路径
 @param complete 当前歌曲播放完毕, 播放下一首
 */
- (void)playMusicWithSongUrl:(NSURL *)songUrl didComplete:(void (^)())complete;

/**
 暂停后播放歌曲
 */
- (void)play;

/**
 暂停
 */
- (void)pause;
@end
