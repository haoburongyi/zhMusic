//
//  ZHPlayHeader.m
//  zhMusic
//
//  Created by 张淏 on 17/1/1.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import "ZHPlayHeader.h"
#import "Header.h"
#import "ZHButton.h"

@implementation ZHPlayHeader {
//    UIImageView *_artworkImg;
}

- (void)setCurrentSong:(MPMediaItem *)currentSong {
    _currentSong = currentSong;
    // MPMediaItemPropertyArtwork          专辑图
    // MPMediaItemArtwork *artwork = [song valueForProperty:MPMediaItemPropertyArtwork];
    MPMediaItemArtwork *artwork = [currentSong valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *img = [artwork imageWithSize:self.artworkImageVIew.bounds.size];
    self.artworkImageVIew.image = img ? img : [UIImage new];
}
+ (instancetype)playHeaderWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    CGFloat artworkMargin = ZHSCaleW(110);
    
    _artworkImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(artworkMargin, artworkMargin, self.width - artworkMargin * 2, self.width - artworkMargin * 2)];
    _artworkImageVIew.backgroundColor = ZHRGBColor(177, 177, 177);
    [self addSubview:_artworkImageVIew];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
