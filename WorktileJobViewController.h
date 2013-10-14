//
//  WorktileJobViewController.h
//  WorktileProduct
//
//  Created by TerryLee on 13-9-19.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "BasicViewController.h"

@interface WorktileJobViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSDictionary *_dataSource;
    NSArray *_allSheng;
    NSArray *_allShi;
    NSArray *_city;
    int _currentPage;
    
}

@end
