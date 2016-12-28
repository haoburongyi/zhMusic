//
//  ZHMusicInfo.h
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Realm.h>

@interface ZHMusicInfo : RLMObject

@property (nonatomic, copy)     NSString    *assetURL;
@property (nonatomic, strong)   NSData      *data;
@end

