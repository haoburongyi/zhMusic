//
//  Header.h
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#ifndef Header_h

#import "UIView+Extension.h"

/**
 *  主窗口
 */
#define ZHWindow [UIApplication sharedApplication].keyWindow

/**
 *  最上面的窗口
 */
#define ZHtopWindow [[UIApplication sharedApplication].windows lastObject]

/**
 *  屏幕尺寸
 */
#define ZHScreenSize [UIScreen mainScreen].bounds.size

/**
 *  屏幕宽度
 */
#define ZHMainScreenW [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕高度
 */
#define ZHMainScreenH [UIScreen mainScreen].bounds.size.height

/**
 *  ScreenBounds
 */
#define ZHScreenBounds [UIScreen mainScreen].bounds

/**
 *  NSLog
 */
#ifdef DEBUG // 处于开发阶段
#define NSLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define NSLog(...)
#endif

/**
 *  RGB颜色
 */
#define ZHRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/**
 *  ARGB颜色
 */
#define ZHARGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/**
 *  随机色
 */
#define ZHRandomColor ZHARGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),arc4random_uniform(256))

/**
 *  屏幕比
 */
#define ZHSCaleW(x) ZHMainScreenW * (x / 375.0)
#define ZHSCaleH(x) ZHMainScreenH * (x / 667.0)

/**
 *  选中颜色
 */
#define ZHRedColor ZHRGBColor(255, 45, 85)


#define MusicListKey @"MusicListKey"

#define Header_h
#endif /* Header_h */
