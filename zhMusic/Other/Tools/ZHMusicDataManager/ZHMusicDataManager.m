//
//  ZHMusicDataManager.m
//  zhMusic
//
//  Created by 张淏 on 17/1/2.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import "ZHMusicDataManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Realm.h>
#import "ZHMusicInfo.h"


@implementation ZHMusicDataManager
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
            
            RLMResults *tempInfo = [ZHMusicInfo objectsWhere:[NSString stringWithFormat:@"assetURL = '%@'", song.assetURL.absoluteString]];
            
            if (tempInfo.count != 0) {
                continue;
            }
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:song];
            
            ZHMusicInfo *info = [[ZHMusicInfo alloc] init];
            info.assetURL = song.assetURL.absoluteString;
            info.groupName = @"全部音乐";
            info.data = data;
            
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [[RLMRealm defaultRealm] addObject:info];
            }];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"加载数据完成");
        });
    });
}

@end
