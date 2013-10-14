//
//  BasicViewController.h
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataRequest.h"

@interface BasicViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    UIPageControl *_pageControl;
    
    NSMutableArray *_dataSource;
    
    int _currentPage;
    
    UIView *_loginView;
    
    UIImageView *_imageView;
    
    UIView *_smallView;
    
    UIImageView *_logoImageView;
    
    UITextField *_nameTextField;
    
    UITextField *_passTextField;
    
    DataRequest *_dataRequest;
}

@end
