//
//  CJTextCycleView.m
//  CJTextCycleScrollView
//
//  Created by CJ on 2017/4/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "CJTextCycleView.h"
#import "CJTextCycleCell.h"

@interface CJTextCycleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView * collectionView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, weak) NSTimer * timer;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger textCount;

@end

@implementation CJTextCycleView

- (NSInteger)currentPage
{
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self initialization];
        [self setupCollectionView];
    }
    return self;
}

- (void)initialization
{
    _timeInterval = 2.0;
}

// 设置collectionView
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = self.bounds.size;
    self.flowLayout = flowLayout;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollsToTop = NO;
    collectionView.scrollEnabled = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"CJTextCycleCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:@"CJTextCycleCell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
}

//设置数据
- (void)setTexts:(NSArray *)texts
{
    _texts = texts;
    
    self.textCount = texts.count * 10000;
    [self.collectionView reloadData];
    
    //先消除timer
    [self invalidateTimer];
    //开启定时器
    [self setupTimer];
}

//设置时间间隔
- (void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    
    //先消除timer
    [self invalidateTimer];
    //开启定时器
    [self setupTimer];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollToNextText) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scrollToNextText
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    if (self.currentPage == self.textCount - 1) {//如果是最后一个
        self.currentPage = 0;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    self.currentPage ++;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.textCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    long realIndex = indexPath.item % self.texts.count;
    NSString *title = self.texts[realIndex];
    
    CJTextCycleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CJTextCycleCell" forIndexPath:indexPath];
    
    [cell setTitle:title type:arc4random()%3];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //...
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)invalidateTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

@end
