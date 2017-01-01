//
//  ZHMusicInfo.h
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm.h>


// song.playbackDuration 时间
// MPMediaItemPropertyPodcastTitle     专辑
// MPMediaItemPropertyArtist           歌手
// MPMediaItemPropertyAssetURL         播放路径
// MPMediaItemPropertyTitle            歌曲名
// MPMediaItemPropertyPodcastTitle     专辑名
// MPMediaItemPropertyArtwork          专辑图
// MPMediaItemArtwork *artwork = [song valueForProperty:MPMediaItemPropertyArtwork];
// UIImage *img = [artwork imageWithSize:CGSizeMake(100, 100)];

@interface ZHMusicInfo : RLMObject
@property (nonatomic, copy)     NSString    *groupName;
@property (nonatomic, copy)     NSString    *assetURL;
@property (nonatomic, strong)   NSData      *data;
@end

