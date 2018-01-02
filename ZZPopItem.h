//
//  ZZPopItem.h
//  Test
//
//  Created by JB-Mac on 2017/12/28.
//  Copyright © 2017年 yanshi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZZPopItem : UIView
@property (nonatomic, copy) NSArray *titlesArray;        //标题
@property (nonatomic, weak) id delegate;
@end
@protocol ZZPopItemDelegate <NSObject>
- (void)didSelectedIndex:(NSInteger)index;
@end