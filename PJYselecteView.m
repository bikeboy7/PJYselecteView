//
//  PJYselecteView.m
//  小控件调试
//
//  Created by boy on 2017/8/17.
//  Copyright © 2017年 pjy. All rights reserved.
//

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


#import "PJYselecteView.h"

@interface PJYselecteView ()<UIScrollViewDelegate>

@property (retain,nonatomic) UIScrollView * scrollView;

@property (retain,nonatomic) UIScrollView * scrollView2;

@property (retain,nonatomic) NSMutableArray * imageViewArray;




@end

@implementation PJYselecteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    [self resetView];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    
}


- (void)initView {
    
    self.dataArray = [[NSMutableArray alloc] init];

    [self setupScrollView];
    

}

- (void)setupScrollView{
    
    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:_scrollView];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    _scrollView2 = [[UIScrollView alloc] init];
    [self addSubview:_scrollView2];
    _scrollView2.bounces = NO;
    _scrollView2.showsHorizontalScrollIndicator = NO;
    _scrollView2.showsVerticalScrollIndicator = NO;
    _scrollView2.delegate = self;
    _scrollView2.pagingEnabled = YES;
    
    _scrollView2.backgroundColor = [UIColor clearColor];
    
    
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView2.frame = _scrollView.frame;
    
}

- (void)resetView {
    
    _imageViewArray = [[NSMutableArray alloc] init];
    
    _scrollView2.contentSize = CGSizeMake(_dataArray.count * ScreenWidth, _scrollView2.frame.size.height);
    
    _scrollView.contentSize = CGSizeMake((_dataArray.count + 2) * ScreenWidth / 3, _scrollView.frame.size.height);
    for (UIView * view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < _dataArray.count; i ++) {
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        imageView.frame = CGRectMake((i + 1) * ScreenWidth / 3.0, 10, ScreenWidth / 3.0, _scrollView.frame.size.height - 10);
        if ([_dataArray[i] isKindOfClass:[UIImage class]]) {
            imageView.image = _dataArray[i];
        }else {
            //[imageView setImageWithURL:[NSURL URLWithString:item.album_url] placeholderImage:[UIImage imageNamed:@"img_default_topic_cover.png"]];
        }
        
        CGAffineTransform transform2= CGAffineTransformMakeRotation(M_PI*0.05 * i);
        imageView.transform = transform2;
        
        [_imageViewArray addObject:imageView];

        [_scrollView addSubview:imageView];
        
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 3 + i * ScreenWidth, 0, ScreenWidth / 3, _scrollView.frame.size.height)];
        view.tag = i + 10;
        [view addGestureRecognizer:tap];
        [_scrollView2 addSubview:view];

        
    }


}

#pragma mark - 图片点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
   
    NSLog(@"%ld", tap.view.tag);
}


#pragma mark - 滚动视图代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _scrollView.contentOffset = CGPointMake(_scrollView2.contentOffset.x / 3.0, _scrollView2.contentOffset.y);
    
    for (int j = 0; j < _imageViewArray.count; j ++) {
        UIImageView * imageView = _imageViewArray[j];
        
        float nowf = _scrollView2.contentOffset.x / 3.0;
        
        float otherf = imageView.frame.origin.x;
        
        CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*(otherf - nowf - ScreenWidth / 3) / 1500);
        
        imageView.transform = transform;
        
        if (imageView.tag - 10 == (int)_scrollView2.contentOffset.x / ScreenWidth) {
        }
    }
}







@end
