//
//  ZHPlayMusicManager+Extension.m
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayMusicManager+Extension.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Realm.h>
#import "ZHMusicInfo.h"

@implementation ZHPlayMusicManager (Extension)
+ (void)checkAllMusic {
    //    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    MPMediaQuery *everything = [MPMediaQuery songsQuery];
    NSLog(@"Logging items from a generic query...");
    NSArray *itemsFromGenericQuery = [everything items];
    NSLog(@"ipod count = %lu", (unsigned long)itemsFromGenericQuery.count);
    
    RLMResults *infoArr = [ZHMusicInfo allObjects];
    
    infoArr.count == itemsFromGenericQuery.count ? : [self getAllMusic:itemsFromGenericQuery];
}

+ (void)getAllMusic:(NSArray *)itemsFromGenericQuery {
    
    NSLog(@"加载了数据");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (MPMediaItem *song in itemsFromGenericQuery) {
            //        song.playbackDuration 时间
            //        MPMediaItemPropertyPodcastTitle     专辑
            
            //        MPMediaItemPropertyArtwork          专辑图
            //            MPMediaItemArtwork *artwork = [song valueForProperty:MPMediaItemPropertyArtwork];
            //            UIImage *img = [artwork imageWithSize:CGSizeMake(100, 100)];
            
            //        MPMediaItemPropertyAssetURL         播放路径
            //            NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
            //            NSString *songArtist = [song valueForProperty:MPMediaItemPropertyArtist];
            //            NSString *podcastTitle = [song valueForProperty:MPMediaItemPropertyPodcastTitle];
            
            RLMResults *tempInfo = [ZHMusicInfo objectsWhere:[NSString stringWithFormat:@"assetURL = '%@'", song.assetURL]];
            
            if (tempInfo.count != 0) {
                continue;
            }
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:song];
            
            ZHMusicInfo *info = [[ZHMusicInfo alloc] init];
            info.assetURL = song.assetURL.absoluteString;
            info.data = data;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    [[RLMRealm defaultRealm] addObject:info];
                }];
            });
        }
        NSLog(@"加载数据完成");
    });
}

@end
