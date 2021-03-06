//
//  CJTextCycleCell.h
//  CJTextCycleScrollView
//
//  Created by CJ on 2017/4/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Type) {
    FIRST = 0,
    SECOND,
    THIRD
};

@interface CJTextCycleCell : UICollectionViewCell

- (void)setTitle:(NSString *)title type:(Type)type;

@end
