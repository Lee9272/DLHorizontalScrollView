//
//  ViewController.m
//  DLHorizontalScrollView
//
//  Created by Lee on 1/2/15.
//  Copyright (c) 2015 Scau. All rights reserved.
//

#import "ViewController.h"
#import "DLHorizontalScrollView.h"

@interface ViewController () <DLHorizontalScrollViewDelegate>
@property (weak, nonatomic) IBOutlet DLHorizontalScrollView *dlScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dlScrollView setItems:@[@"", @"", @"", @"", @"", @"", @"", @""]];
    self.dlScrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollView:(DLHorizontalScrollView *)scrollView didScrollToItemAtIndex:(int)index
{
    NSLog(@"%d", index);
}

@end
