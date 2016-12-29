//
//  ZHPlayMusicListManager.m
//  zhMusic
//
//  Created by 张淏 on 16/12/29.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayMusicListManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Realm.h>
#import "ZHMusicInfo.h"
#import "pinyin.h"

@implementation ZHPlayMusicListManager

static ZHPlayMusicListManager *_manager;
+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)loadAllMusicComplation:(void(^)(NSArray *header, NSDictionary *allMusic))complation {
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 取所有音乐
        RLMResults *musics = [ZHMusicInfo allObjects];
        
        NSMutableArray *muArr = [NSMutableArray array];
        for (ZHMusicInfo *musicInfo in musics) {
            MPMediaItem *song = [NSKeyedUnarchiver unarchiveObjectWithData:musicInfo.data];
            [muArr addObject:song];
        }
        
        NSDictionary *modelDict = [muArr sortedArrayUsingFirstLetterByKeypath:@"title"];
        NSLog(@"modelDict:%@", modelDict);
        NSLog(@"allKey:%@", modelDict.allKeys);
        
        NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
        NSWidthInsensitiveSearch|NSForcedOrderingSearch;
        NSComparator sort = ^(NSString *obj1,NSString *obj2){
            NSRange range = NSMakeRange(0,obj1.length);
            return [obj1 compare:obj2 options:comparisonOptions range:range];
        };
        
        
        NSMutableArray *tempHeaderArr = [modelDict.allKeys sortedArrayUsingComparator:sort].mutableCopy;
        if ([tempHeaderArr containsObject:@"#"]) {
            [tempHeaderArr removeObject:@"#"];
            [tempHeaderArr addObject:@"#"];
        }
        
        NSLog(@"字符串数组排序结果%@",tempHeaderArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            complation(tempHeaderArr.copy, modelDict);
        });
    });
    
}


@end
