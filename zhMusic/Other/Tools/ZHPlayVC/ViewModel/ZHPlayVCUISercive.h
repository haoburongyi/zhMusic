//
//  ZHPlayVCUISercive.h
//  zhMusic
//
//  Created by 张淏 on 17/1/1.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZHPlayVCUISercive : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<MPMediaItem *> *playList;


@end
