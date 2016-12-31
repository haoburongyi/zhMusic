//
//  ZHMiniPlayView.m
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMiniPlayView.h"
#import "Header.h"

@interface ZHMiniPlayView ()
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ZHMiniPlayView

static ZHMiniPlayView *_defaultView;
+ (instancetype)defaultView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _defaultView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 63.5)];
        [_defaultView createUI];
        _defaultView.clipsToBounds = YES;
        _defaultView.height = 0;
    });
    return _defaultView;
}


- (void)showWith {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PlayMusicNoti object:PlayMusicNoti];

        CGFloat height = 63.5;
        [UIView animateWithDuration:0.25 animations:^{
            self.y -= height;
            self.height += height;
        }];
    });
}


- (void)createUI {

    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.frame;
    [self addSubview:effectView];
    
    [self setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
    
    
    CGFloat topMargin = 8;
    
    _artworkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, topMargin, self.height - topMargin * 2, self.height - topMargin * 2)];
    _artworkImageView.backgroundColor = ZHRGBColor(177, 177, 177);
    _artworkImageView.layer.cornerRadius = 6;
    _artworkImageView.layer.masksToBounds = YES;
    [self addSubview:_artworkImageView];
    
    _next = [[UIButton alloc] init];
    [_next setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Next_26x16_"] forState:UIControlStateNormal];
    [_next sizeToFit];
    _next.origin = CGPointMake(self.width - _next.width - 20, self.height * 0.5 - _next.height * 0.5);
    [self addSubview:_next];
    
    _pause = [[UIButton alloc] init];
    [_pause setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Pause_19x19_"] forState:UIControlStateNormal];
    [_pause setImage:[UIImage imageNamed:@"MiniPlayer-Transport-Play_19x19_"] forState:UIControlStateSelected];
    [_pause sizeToFit];
    _pause.origin = CGPointMake(_next.x - _pause.width - 23, self.height * 0.5 - _pause.height * 0.5);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
