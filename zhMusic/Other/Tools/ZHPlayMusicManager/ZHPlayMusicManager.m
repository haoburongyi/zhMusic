//
//  ZHPlayMusicManager.m
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayMusicManager.h"
#import <AVFoundation/AVFoundation.h>
#import "Header.h"


@interface ZHPlayMusicManager ()<AVAudioPlayerDelegate>
// 播放音乐的对象
@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, copy) NSURL *songUrl;

@property (nonatomic, copy) void (^complete)();
@end

@implementation ZHPlayMusicManager

static ZHPlayMusicManager *_manager;
+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZHPlayMusicManager alloc] init];
        // 处理中断事件的通知, 如来电
        [[NSNotificationCenter defaultCenter] addObserver:_manager selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
        });
    return _manager;
}
// 处理中断事件
- (void)handleInterreption:(NSNotification *)sender
{
    if(self.player.isPlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
}

#pragma mark - 播放歌曲
// 播放歌曲
- (void)playMusicWithSongUrl:(NSURL *)songUrl didComplete:(void (^)())complete {
    if (![self.songUrl isEqual:songUrl]) {
        
        self.songUrl = songUrl;
        
        NSError *error = nil;
        
        // 创建播放对象,并且实例化
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:&error];
        if (error) {
            NSLog(@"创建播放对象,并且实例化失败%@",error);
            return;
        }
        
        // 保存block
        self.complete = complete;
        
        self.player.delegate = self;
        
        // 准备播放
        [self.player prepareToPlay];
    }
    
    // 播放
    [self.player play];
}
- (void)play {
    !_songUrl ? : NSLog(@"%d", [self.player play]);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.complete();
    //        [self complete];
}


#pragma mark - 暂停
- (void)pause {
    [self.player pause];
}

#pragma mark - setter && getter
- (NSTimeInterval)currentTime {
    return self.player.currentTime;
}

-(NSTimeInterval)duration {
    return self.player.duration;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    self.player.currentTime = currentTime;
}

@end
