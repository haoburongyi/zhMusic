//
//  ZHMusicHeader.h
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditMusicListBlock)(UIButton *sender);

@interface ZHMusicHeader : UIView

@property (nonatomic, copy)EditMusicListBlock editClick;

@end
