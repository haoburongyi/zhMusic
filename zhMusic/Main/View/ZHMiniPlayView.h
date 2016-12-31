//
//  ZHMiniPlayView.h
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZHMiniPlayView : UIView

+ (instancetype)defaultView;
- (void)showWithItem:(MPMediaItem *)item;
- (void)setPuserBtnSelect;
@end
