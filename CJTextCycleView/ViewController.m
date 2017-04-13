//
//  ViewController.m
//  CJTextCycleView
//
//  Created by CJ on 2017/4/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "ViewController.h"
#import "CJTextCycleView.h"

@interface ViewController ()

@property (nonatomic, strong) CJTextCycleView * textCycleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textCycleView = [[CJTextCycleView alloc]initWithFrame:CGRectMake(0, 100, 375, 50)];
    self.textCycleView.texts = @[@"青花瓷1",@"素胚勾勒出青花笔锋浓转淡2",@"瓶身描绘的牡丹一如你初妆3",@"宣纸上走笔至此搁一半4",@"釉色渲染仕女图韵味被私藏5",@"而你嫣然的一笑如含苞待放6",@"你的美一缕飘散7",@"去到我去不了的地方8"];
    self.textCycleView.timeInterval = 1.5;
    
    [self.view addSubview:self.textCycleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
