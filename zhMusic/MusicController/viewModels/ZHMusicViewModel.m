//
//  ZHMusicViewModel.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicViewModel.h"

@implementation ZHMusicViewModel


/**
 loadData

 @param completion 这里用回调是模拟网络回调
 */
- (void)loadDataCompletion:(void(^)(NSArray *list))completion {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"musicGroupList" ofType:@"plist"];
    NSArray *list = [NSArray arrayWithContentsOfFile:path];
    completion(list);
}

@end
