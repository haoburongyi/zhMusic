//
//  UIImage+Extension.h
//  CarIn
//
//  Created by 张淏 on 15/5/29.
//  Copyright (c) 2015年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface UIImage (Extension)

/**
 根据当前图像，和指定的尺寸，生成圆角图像并且返回

 @param size imageView 的 size
 @param fillColor  背景色
 @param completion 回调 image
 */
- (void)zh_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

/**
 根据当前图像，和指定的尺寸，生成指定角度圆角图像并且返回

 @param size imageView 的 size
 @param cornerRadius 要裁剪的角度
 @param fillColor 背景色
 @param completion 回调 image
 */
- (void)zh_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

+ (UIImage *)defaultImageWithSongItem:(MPMediaItem *)item size:(CGSize)size;
@end
