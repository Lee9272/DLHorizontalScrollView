//
//  DLHorizontalScrollView.h
//  DLHorizontalScrollView
//
//  Created by Lee on 1/2/15.
//  Copyright (c) 2015 Scau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLHorizontalScrollView;
@protocol DLHorizontalScrollViewDelegate <NSObject>
- (void)scrollView:(DLHorizontalScrollView *)scrollView didScrollToItemAtIndex:(int)index;
@end

@interface DLHorizontalScrollView : UIView

@property (nonatomic, weak) id<DLHorizontalScrollViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items;
- (void)setItems:(NSArray *)items;

@end
