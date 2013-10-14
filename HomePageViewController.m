//
//  HomePageViewController.m
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.navigationItem.title = @"Worktile";
    
//    self.view.backgroundColor = [UIColor colorWithWhite:16514043 alpha:1] ;
//    
//    UIButton *loginButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
//    loginButton.frame = CGRectMake(100, 410, 100, 40);
//    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [loginButton addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginButton];
//    [loginButton release];
//    
//    
//    //把图片装到数组里
//    _dataSource = [[NSMutableArray alloc] init];
//    for (int i=1; i<=7; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
//        [_dataSource addObject:image];
//    }
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,320 , 400)];
//    
//    _scrollView.showsVerticalScrollIndicator = NO;
//    
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    
//    _scrollView.delegate = self;
//    
//    _scrollView.pagingEnabled = YES;
//    
//    _scrollView.contentSize = CGSizeMake(320 * [_dataSource count], 400);
//    
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 330, 300, 20)];
//    
//    _pageControl.currentPage = 0;
//    
//    _pageControl.numberOfPages =  [_dataSource count];
//    
//    [_pageControl addTarget:self action:@selector(clickPageController:) forControlEvents:UIControlEventValueChanged];
//    
//    _pageControl.enabled = NO;
//    
//    [self.view addSubview:_scrollView];
//    
//    [self.view addSubview:_pageControl];
//    
//    _currentPage = 0;
//    
//    
//    [self reloadImage];
    
    
}

//- (void)reloadImage
//{
//    _pageControl.currentPage = _currentPage;
//    
//    for (UIView *view in [_scrollView subviews]) {
//        [view removeFromSuperview];
//    }
//    int prepage = [self getPage:_currentPage - 1];
//    int nextPage = [self getPage:_currentPage +1];
//    
//    UIImage *image1 = [_dataSource objectAtIndex:prepage];
//    UIImageView *preImageView = [[UIImageView alloc]initWithImage:image1];
//    preImageView.frame = CGRectMake(0, 0, 320, 400);
//    [_scrollView addSubview:preImageView];
//    [preImageView release];
//    
//    UIImage *image2 = [_dataSource objectAtIndex:_currentPage];
//    UIImageView *currentImageView = [[UIImageView alloc]initWithImage:image2];
//    currentImageView.frame = CGRectMake(320, 0, 320, 400);
//    [_scrollView addSubview:currentImageView];
//    [currentImageView release];
//    
//    UIImage *image3 = [_dataSource objectAtIndex:nextPage];
//    UIImageView *nextImageView = [[UIImageView alloc]initWithImage:image3];
//    nextImageView.frame = CGRectMake(640, 0, 320, 400);
//    [_scrollView addSubview:nextImageView];
//    [nextImageView release];
//    
//    [_scrollView setContentOffset:CGPointMake(320, 0)];
//    
//}
//
//- (NSInteger)getPage:(NSInteger)page
//{
//    if(page == [_dataSource count]){
//        page = 0;
//    }else if(page == -1){
//        page = [_dataSource count]-1;
//    }
//    return page;
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat x = scrollView.contentOffset.x;
//    if(x >= 640){
//        _currentPage = [self getPage:_currentPage+1];
//        [self reloadImage];
//    }else if (x <= 0){
//        _currentPage = [self getPage:_currentPage-1];
//        [self reloadImage];
//    }
//}
//
//
//-(void)loginView
//{
//   // LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    //[loginViewController viewWillAppear:YES];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
