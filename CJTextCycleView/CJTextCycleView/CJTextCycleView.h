//
//  CJTextCycleView.h
//  CJTextCycleScrollView
//
//  Created by CJ on 2017/4/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJTextCycleView : UIView

/**
 轮播时间间隔 默认2S
 */
@property (nonatomic, assign) CGFloat timeInterval;

/**
 文本数据源
 */
@property (nonatomic, strong) NSArray * texts;

@end
