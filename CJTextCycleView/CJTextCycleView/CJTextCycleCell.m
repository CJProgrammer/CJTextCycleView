//
//  CJTextCycleCell.m
//  CJTextCycleScrollView
//
//  Created by CJ on 2017/4/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "CJTextCycleCell.h"

@interface CJTextCycleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CJTextCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setTitle:(NSString *)title type:(Type)type
{
    self.titleLabel.text = title;
    
    if (type == FIRST) {
        self.titleLabel.textColor = [UIColor yellowColor];
    } else if (type == SECOND) {
        self.titleLabel.textColor = [UIColor redColor];
    } else if (type == THIRD) {
        self.titleLabel.textColor = [UIColor magentaColor];
    }
}

@end
