//
//  ZHTableView.m
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTableView.h"
#import "Header.h"

@implementation ZHTableView

- (instancetype)init {
    if (self = [super init]) {
        [self addNoti];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addNoti];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self addNoti];
    }
    return self;
}

- (void)addNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBottomInset) name:PlayMusicNoti object:PlayMusicNoti];
}
- (void)changeBottomInset {
#warning 49 改为全局的 bottom 的高
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom + 49, self.contentInset.right);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PlayMusicNoti object:PlayMusicNoti];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
