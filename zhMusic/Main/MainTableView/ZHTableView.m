//
//  ZHTableView.m
//  zhMusic
//
//  Created by 张淏 on 16/12/31.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTableView.h"
#import "Header.h"
#import "ZHMiniPlayView.h"
#import "ZHPlayMusicManager.h"

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
    
    if ([ZHMiniPlayView defaultView].height) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom + [ZHMiniPlayView defaultView].height, self.contentInset.right);
        });
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBottomInset) name:PlayMusicNoti object:nil];
}
- (void)changeBottomInset {
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom + [ZHMiniPlayView defaultView].height, self.contentInset.right);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PlayMusicNoti object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
