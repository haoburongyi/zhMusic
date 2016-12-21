//
//  ZHMusicHeader.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicHeader.h"
#import "Header.h"

@implementation ZHMusicHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UILabel *title = [UILabel new];
    [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:34]];
    title.textColor = [UIColor blackColor];
    title.text = @"音乐资料库";
    [title sizeToFit];
    title.origin = CGPointMake(15, self.height - title.bounds.size.height);
    [self addSubview:title];
    
    UIButton *edit = [UIButton new];
    [edit setTitle:@"编辑" forState: UIControlStateNormal];
    [edit setTitle:@"完成" forState: UIControlStateSelected];
    edit.titleLabel.font = [UIFont systemFontOfSize:14];
    [edit setTitleColor:ZHRedColor forState:UIControlStateNormal];
    [edit setTitleColor:ZHRedColor forState:UIControlStateSelected];
    [edit sizeToFit];
    edit.origin = CGPointMake(self.width - 20 - edit.width, self.height - edit.height);
    [edit addTarget:self action:@selector(editMusicList:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:edit];
}

- (void)editMusicList:(UIButton *)sender {
    sender.selected = !sender.selected;
    !self.editClick?: self.editClick(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
