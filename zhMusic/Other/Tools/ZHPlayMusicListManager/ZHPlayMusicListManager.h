//
//  ZHPlayMusicListManager.h
//  zhMusic
//
//  Created by 张淏 on 16/12/29.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHPlayMusicListManager : NSObject

+ (instancetype)defaultManager;

/**
 全部音乐列表

 @param complation 回调 header 组和数据源
 */
- (void)loadAllMusicComplation:(void(^)(NSArray *header, NSDictionary *allMusic))complation;
@end
