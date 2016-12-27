//
//  ZHMusicViewModel.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicViewModel.h"
#import "Header.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Photos/Photos.h>

@implementation ZHMusicViewModel


/**
 loadData

 @param completion 这里用回调是模拟网络回调
 */
- (void)loadDataCompletion:(void(^)(NSArray *_library))completion {
    

    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:MusicListKey];
    
    if (!arr) {
        arr = @[@"全部歌曲", @"表演者", @"专辑"];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
#warning 初始化这三个组的歌曲
        [userDefault setObject:arr forKey:MusicListKey];
        [userDefault synchronize];
    }
    completion(arr);
    
    [self QueryAllMusic];
}

- (void)QueryAllMusic
{
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    NSLog(@"Logging items from a generic query...");
    NSArray *itemsFromGenericQuery = [everything items];
    NSLog(@"count = %lu", (unsigned long)itemsFromGenericQuery.count);
    
    NSMutableArray *muArr = [NSMutableArray array];
    for (MPMediaItem *song in itemsFromGenericQuery)
    {
//        song.playbackDuration 时间
//        song.podcastTitle     专辑
        
        MPMediaItemArtwork *artwork = song.artwork;
        UIImage *img = [artwork imageWithSize:CGSizeMake(100, 100)];
        
        !img ? [muArr addObject:[UIImage imageNamed:@"MissingArtworkMusicNote200_200x200_@1x"]] : [muArr addObject:img];
        
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSString *songArtist = [song valueForProperty:MPMediaItemPropertyArtist];
        NSLog (@"Title:%@, Aritist:%@", songTitle, songArtist);
    }
    

}

@end
