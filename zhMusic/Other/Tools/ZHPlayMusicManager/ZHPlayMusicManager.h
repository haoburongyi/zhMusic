//
//  ZHPlayMusicManager.h
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZHPlayMusicManager : NSObject

+ (instancetype)shareManage;

/**
 加载组内信息 \ 样式

 @param groupName title
 */
- (void)loadMusicInfoWithGroupName:(NSString *)groupName;

@end
