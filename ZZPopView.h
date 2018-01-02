//
//  ZZPopView.h
//  Test
//
//  Created by JB-Mac on 2017/12/28.
//  Copyright © 2017年 yanshi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ZZPattern) {
    ZZPatternTop = 1,
    ZZPatternRight,
    ZZPatternBottom,
    ZZPatternLeft,
};
/**
 上左为近  下右为远  吸附位置
 */
typedef NS_OPTIONS(NSInteger, ZZLocation) {
    ZZLocationNear = 1,     //近点
    ZZLocationCenter,       //中点
    ZZLocationFar,          //远点
};
/**
 上左为近  下右为远  指示位置
 */
typedef NS_OPTIONS(NSInteger, ZZTrLocation) {
    ZZTrLocationNear = 1,     //近点
    ZZTrLocationCenter,       //中点
    ZZZTrLocationFar,          //远点
};
@interface ZZPopView : UIView
@property (nonatomic, weak) id delegate;
/**
 吸附方向
 */
@property (nonatomic, assign) ZZPattern zPattern;
/**
 小三角形吸附位置
 */
@property (nonatomic, assign) ZZLocation zTrtLocation;
/**
 小三角形指示位置
 */
@property (nonatomic, assign) ZZTrLocation zTrbLocation;
/**
 三角形显示位置 0.0-1.0 相对于自身
 */
@property (nonatomic, assign) CGFloat trtLocation;
/**
 三角形显示位置 0.0-1.0 相对于被吸附视图
 */
@property (nonatomic, assign) CGFloat trbLocation;
/**
 展示
 */
- (void)show;
/**
 直接展示
 */
+ (ZZPopView *)adjacent:(UIView *)view titles:(NSArray *)titles;
@end
@protocol ZZPopViewDelegate <NSObject>
/**
 回调选择下标
 */
- (void)popSelectIndex:(NSInteger)index;

@end