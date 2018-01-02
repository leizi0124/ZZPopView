//
//  ZZPopView.m
//  Test
//
//  Created by JB-Mac on 2017/12/28.
//  Copyright © 2017年 yanshi. All rights reserved.
//

#import "ZZPopView.h"
#import "ZZPopItem.h"
@interface ZZPopView ()<ZZPopItemDelegate>
@property (nonatomic, assign) CGRect zFrame;                //被吸附视图位置
@property (nonatomic, strong) CAShapeLayer *subLayer;       //背景layer
@property (nonatomic, strong) ZZPopItem *itemView;          //内部视图
@property (nonatomic, copy) NSArray *titlesArray;           //标题
@end
@implementation ZZPopView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.itemView = [[ZZPopItem alloc] init];
        self.itemView.delegate = self;
        [self addSubview:self.itemView];
    }
    return self;
}
#pragma mark - 以默认方式展示
+ (ZZPopView *)adjacent:(UIView *)view titles:(NSArray *)titles {
    
    ZZPopView *popView = [[ZZPopView alloc] init];
    popView.zPattern = ZZPatternTop;
    popView.zFrame = view.frame;
    popView.titlesArray = titles;
    popView.zTrtLocation = ZZLocationCenter;
    popView.zTrbLocation = ZZTrLocationCenter;
    
    [popView adjustFrame];
    
    [popView draw];
    [popView show];
    
    popView.itemView.titlesArray = titles;
    
    return popView;
}
- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
//    [self draw];
//    [self layout];
    [self adjustFrame];
}
#pragma mark - 吸附位置
- (void)setZTrtLocation:(ZZLocation)zTrtLocation {
    _zTrtLocation = zTrtLocation;
    switch (zTrtLocation) {
        case ZZLocationNear:
            self.trtLocation = 0.2;
            break;
        case ZZLocationCenter:
            self.trtLocation = 0.5;
            break;
        case ZZLocationFar:
            self.trtLocation = 0.8;
            break;
        default:
            break;
    }
}
#pragma mark - 自身位置
- (void)setZTrbLocation:(ZZTrLocation)zTrbLocation {
    _zTrbLocation = zTrbLocation;
    switch (zTrbLocation) {
        case ZZTrLocationNear:
            self.trbLocation = 0.2;
            break;
        case ZZTrLocationCenter:
            self.trbLocation = 0.5;
            break;
        case ZZZTrLocationFar:
            self.trbLocation = 0.8;
            break;
        default:
            break;
    }
}
#pragma mark - 吸附方向
- (void)setZPattern:(ZZPattern)zPattern {
    _zPattern = zPattern;
    [self draw];
    [self layout];
}
#pragma mark - 自定义吸附位置
- (void)setTrtLocation:(CGFloat)trtLocation {
    _trtLocation = trtLocation < 0.0 ? 0.0 : trtLocation;
    _trtLocation = trtLocation > 1.0 ? 1.0 : trtLocation;
    [self draw];
    [self layout];
}
#pragma mark - 自定义自身位置
- (void)setTrbLocation:(CGFloat)trbLocation {
    _trbLocation = trbLocation < 0.0 ? 0.0 : trbLocation;
    _trbLocation = trbLocation > 1.0 ? 1.0 : trbLocation;
    [self layout];
}
#pragma mark - 重绘三角形位置
- (void)draw {

    if (self.subLayer) {
        [self.subLayer removeFromSuperlayer];
    }
    
    self.subLayer = [CAShapeLayer layer];
    self.subLayer.frame = self.bounds;
    [self.subLayer setFillColor:[self colorWithString:@"313131"].CGColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint point1 = CGPointZero;
    CGPoint point2 = CGPointZero;
    CGPoint point3 = CGPointZero;
    CGPoint point4 = CGPointZero;
    CGPoint point5 = CGPointZero;
    CGPoint point6 = CGPointZero;
    CGPoint point7 = CGPointZero;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    switch (self.zPattern) {
        case ZZPatternTop:{
            point2 = CGPointMake(width, 0);
            point3 = CGPointMake(width, height - 5);
            point4 = CGPointMake((width * _trtLocation + 5) > width ? width : (width * _trtLocation + 5), height - 5);
            point5 = CGPointMake(width * _trtLocation, height);
            point6 = CGPointMake((width * _trtLocation - 5) < 0 ? 0 : (width * _trtLocation - 5), height - 5);
            point7 = CGPointMake(0, height - 5);
            self.itemView.frame = CGRectMake(0, 0, width, height - 5);
        }
            break;
        case ZZPatternRight:{
            point1 = CGPointMake(width, 0);
            point2 = CGPointMake(width, height);
            point3 = CGPointMake(5, height);
            point4 = CGPointMake(5, (height * _trtLocation + 5) > height ? height : (height * _trtLocation + 5));
            point5 = CGPointMake(0, height * _trtLocation);
            point6 = CGPointMake(5, (height * _trtLocation - 5) < 0 ? 0 : (height * _trtLocation - 5));
            point7 = CGPointMake(5, 0);
            self.itemView.frame = CGRectMake(5, 0, width - 5, height);
        }
            break;
        case ZZPatternBottom:{
            point1 = CGPointMake(width, height);
            point2 = CGPointMake(0, height);
            point3 = CGPointMake(0, 5);
            point4 = CGPointMake((width * _trtLocation - 5) < 0 ? 0 : (width * _trtLocation - 5), 5);
            point5 = CGPointMake(width * _trtLocation, 0);
            point6 = CGPointMake((width * _trtLocation + 5) > width ? width : (width * _trtLocation + 5), 5);
            point7 = CGPointMake(width, 5);
            self.itemView.frame = CGRectMake(0, 5, width, height - 5);
        }
            break;
        case ZZPatternLeft:{
            point1 = CGPointMake(0, 0);
            point2 = CGPointMake(width - 5, 0);
            point3 = CGPointMake(width - 5, (height * _trtLocation - 5) < 0 ? 0 : (height * _trtLocation - 5));
            point4 = CGPointMake(width, height * _trtLocation);
            point5 = CGPointMake(width - 5, (height * _trtLocation + 5) > height ? height : (height * _trtLocation + 5));
            point6 = CGPointMake(width - 5, height);
            point7 = CGPointMake(0, height);
            self.itemView.frame = CGRectMake(0, 0, width - 5, height);
        }
            break;
        default:
            break;
    }
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    
    self.subLayer.path = path.CGPath;
    
    [self.layer insertSublayer:self.subLayer atIndex:0];
}
#pragma mark - 调整自身位置
- (void)layout {

    CGRect frame = self.frame;
    switch (self.zPattern) {
        case ZZPatternTop:{
            CGFloat trX = _zFrame.origin.x + _trbLocation * _zFrame.size.width;
            CGFloat popX = trX - frame.size.width * _trtLocation;
            frame.origin.x = popX;
            frame.origin.y = _zFrame.origin.y - frame.size.height;
        }
            break;
        case ZZPatternRight:{
            CGFloat trY = _zFrame.origin.y + _trbLocation * _zFrame.size.height;
            CGFloat popY = trY - frame.size.height * _trtLocation;
            frame.origin.y = popY;
            frame.origin.x = CGRectGetMaxX(_zFrame);
        }
            break;
        case ZZPatternBottom:{
            CGFloat trX = _zFrame.origin.x + _trbLocation * _zFrame.size.width;
            CGFloat popX = trX - frame.size.width * _trtLocation;
            frame.origin.x = popX;
            frame.origin.y = CGRectGetMaxY(_zFrame);
        }
            break;
        case ZZPatternLeft:{
            CGFloat trY = _zFrame.origin.y + _trbLocation * _zFrame.size.height;
            CGFloat popY = trY - frame.size.height * _trtLocation;
            frame.origin.y = popY;
            frame.origin.x = _zFrame.origin.x - frame.size.width;
        }
            break;
        default:
            break;
    }
    
    self.frame = frame;
}
#pragma mark - 调整自身大小
- (void)adjustFrame {
    CGFloat maxWidth = [self getMaxWidth:self.titlesArray];
    CGRect frame = self.frame;
    frame.size.width = maxWidth + 40.0;
    frame.size.height = 40 * self.titlesArray.count + 3;
    self.frame = frame;
}
#pragma mark - 获取标题的最大宽度
- (CGFloat)getMaxWidth:(NSArray *)titleArray {
    CGFloat maxWidth = 0;
    for (NSString *title in titleArray) {
        CGFloat width = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.width;
        
        maxWidth = maxWidth > width ? maxWidth : width;
    }
    
    return maxWidth;
}
#pragma mark - 回调 选择下标
- (void)didSelectedIndex:(NSInteger)index {
    
    [self close];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popSelectIndex:)]) {
        [self.delegate popSelectIndex:index];
    }
}
#pragma mark - 展示
- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
    [keyWindow addSubview:self];
}
#pragma mark - 关闭
- (void)close {
    [self removeFromSuperview];
}
#pragma mark - rgb颜色
- (UIColor *)colorWithString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
- (void)layoutSubviews {
    
}
@end
