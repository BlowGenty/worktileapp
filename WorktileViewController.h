//
//  WorktileViewController.h
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "BasicViewController.h"
#import "GMGridView.h"

@interface WorktileViewController : UIViewController<GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate,GMGridViewSortingDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    GMGridView *_gridView;
    
    UIImageView *_imageView;
    
    NSMutableArray *_dataSource;
    int _currentPage;
}

@end
