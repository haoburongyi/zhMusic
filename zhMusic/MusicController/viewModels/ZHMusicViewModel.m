//
//  ZHMusicViewModel.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicViewModel.h"
#import "Header.h"

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
}


@end
