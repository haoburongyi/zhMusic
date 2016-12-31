//
//  ZHMiniPlayView.h
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHMiniPlayView : UIView

@property (nonatomic, strong) UIImageView *artworkImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *pause;
@property (nonatomic, strong) UIButton *next;

+ (instancetype)defaultView;
- (void)showWith;
@end
