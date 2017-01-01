//
//  ZHMiniPlayView.m
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMiniPlayView.h"
#import "Header.h"
#import "ZHPlayVC.h"
#import "ZHPlayMusicManager.h"
#import "ZHButton.h"


@interface ZHMiniPlayView ()
@property (nonatomic, strong) UIImageView *artworkImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) ZHButton *pause;
@property (nonatomic, strong) ZHButton *next;

@end

@implementation ZHMiniPlayView

static ZHMiniPlayView *_defaultView;
+ (instancetype)defaultView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
        _defaultView = [[self alloc] initWithFrame:CGRectMake(0, ZHMainScreenH - tabBarControler.tabBar.height, [UIScreen mainScreen].bounds.size.width, 63.5)];
        [_defaultView createUI];
        _defaultView.clipsToBounds = YES;
        _defaultView.height = 0;
        
    });
    return _defaultView;
}


- (void)showWithItem:(MPMediaItem *)item {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat height = 63.5;
        UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
        [UIView animateWithDuration:0.25 animations:^{
            self.y = ZHMainScreenH - height - tabBarControler.tabBar.height;
            self.height += height;
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:PlayMusicNoti object:nil];
    });
    
    self.title.text = [item valueForProperty:MPMediaItemPropertyTitle];
    
    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *img = [artwork imageWithSize:self.artworkImageView.size];
    
    self.artworkImageView.image = img;
}

- (void)showPlayVC {
    
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    
    UINavigationController *nav = tabBarControler.selectedViewController;
    UIViewController *vc = [nav.viewControllers firstObject];
    
    ZHPlayVC *playVC = [ZHPlayVC defaultVC];
    
    if (playVC.isViewLoaded && !playVC.view.window) {// 是否是正在使用的视图
        NSLog(@"showPlayVC");
        [vc presentViewController:playVC animated:YES completion:nil];
    }

    [[UIApplication sharedApplication].keyWindow sendSubviewToBack:self];
}

- (void)pauseMusic:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[ZHPlayMusicManager defaultManager] pause];
    } else {
        [[ZHPlayMusicManager defaultManager] play];
    }
}

- (void)createUI {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPlayVC)];
    [self addGestureRecognizer:tap];

    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:bgView];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.bounds;
    [bgView addSubview:effectView];
    
    [self setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
    
    
    CGFloat topMargin = 8;
    
    _artworkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, topMargin, self.height - topMargin * 2, self.height - topMargin * 2)];
    _artworkImageView.backgroundColor = ZHRGBColor(177, 177, 177);
    _artworkImageView.layer.cornerRadius = 6;
    _artworkImageView.layer.masksToBounds = YES;
    [self addSubview:_artworkImageView];
    
    _next = [[ZHButton alloc] init];
    [_next setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Next_26x16_"] forState:UIControlStateNormal];
    _next.tintColor = ZHRGBColor(77, 77, 77);
    _next.height = self.height;
    _next.width = self.height;
    _next.origin = CGPointMake(self.width - _next.width, 0);
    [self addSubview:_next];
    
    _pause = [[ZHButton alloc] init];
    [_pause setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Pause_19x19_"] forState:UIControlStateNormal];
    [_pause setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Play_19x19_"] forState:UIControlStateSelected];
    _pause.tintColor = ZHRGBColor(77, 77, 77);
    _pause.height = self.height;
    _pause.width = self.height;
//    _pause.width = _pause.width * 2 + 23;
    _pause.origin = CGPointMake(_next.x - _pause.width, 0);
    [_pause addTarget:self action:@selector(pauseMusic:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_pause];
    
    _title = [[UILabel alloc] init];
    _title.text = @"正在载入...";
    CGSize size = [_title.text sizeWithAttributes:@{
                                                    NSFontAttributeName : _title.font
                                                    }];
    
    CGFloat imgMaxX = CGRectGetMaxX(_artworkImageView.frame);
    CGFloat pauseMinX = CGRectGetMinX(_pause.frame);
    _title.frame = CGRectMake(imgMaxX + 10, self.height * 0.5 - size.height * 0.5, pauseMinX - 10 - imgMaxX - 10, size.height);
    [self addSubview:_title];
    
}

- (void)setPuserBtnSelect {
    _pause.selected = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
