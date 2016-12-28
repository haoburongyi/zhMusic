//
//  ZHPlayMusicManager.m
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayMusicManager.h"
#import "ZHPlayMusicManager+Extension.h"
#import "Header.h"


@interface ZHPlayMusicManager ()
//@property (nonatomic, strong) NSArray *
@end

@implementation ZHPlayMusicManager

static ZHPlayMusicManager *_manager;
+ (instancetype)shareManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZHPlayMusicManager alloc] init];
        [self checkAllMusic];
    });
    return _manager;
}

- (void)loadMusicInfoWithGroupName:(NSString *)groupName {
    
}

@end
