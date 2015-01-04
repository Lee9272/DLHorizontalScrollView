//
//  DLHorizontalScrollView.m
//  DLHorizontalScrollView
//
//  Created by Lee on 1/2/15.
//  Copyright (c) 2015 Scau. All rights reserved.
//

#import "DLHorizontalScrollView.h"

@interface DLHorizontalScrollView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *items;
@end

@implementation DLHorizontalScrollView

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    if ([items count]) {
        [self setupView];
    }
}

- (void)setupView
{
    int itemCount = (int)[self.items count];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.pageControl = [UIPageControl new];
    self.pageControl.numberOfPages = itemCount;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"scrollView" : self.scrollView, @"pageControl" : self.pageControl};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageControl]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]|" options:0 metrics:nil views:views]];
    
    if (itemCount <= 1 || itemCount > 8) {
        self.pageControl.hidden = YES;
    }
    
    UIImageView *previousView = [UIImageView new];
    for (int i = 0; i < itemCount; i++) {
        UIImageView *currentView = [UIImageView new];
        
        currentView.image = [self.items[i] isKindOfClass:[UIImage class]] ? self.items[i] : nil;
        currentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:currentView];
        
        // match the sizes of views to their superview
        [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        // align the views one by one
        if (i == 0) {
            [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeading relatedBy:0 toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        } else {
            [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeading relatedBy:0 toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
        }
        
        previousView = currentView;
    }
    
    // the last one should pin to the trailing of superview
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:previousView attribute:NSLayoutAttributeTrailing relatedBy:0 toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didScrollToItemAtIndex:)]) {
        [self.delegate scrollView:self didScrollToItemAtIndex:index];
    }
}

@end
