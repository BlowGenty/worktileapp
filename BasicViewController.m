//
//  BasicViewController.m
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "BasicViewController.h"
#import "LoginViewController.h"
#import "WorktileViewController.h"
#import "DataRequest.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

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
    
    self.view.backgroundColor = [UIColor colorWithWhite:16514043 alpha:1];
    
    self.navigationController.navigationBarHidden=YES;
   
    //把图片装到数组里
    _dataSource = [[NSMutableArray alloc] init];
    for (int i=1; i<=7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [_dataSource addObject:image];
    }
    [self greatScrollandPage];
    [self greatSmallView];
    
    
    [_dataSource autorelease];
    
}

-(void)greatSmallView
{
    
    _smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 320, 60)];
    _smallView.backgroundColor = [UIColor clearColor];
    UIButton *loginButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    loginButton.frame = CGRectMake(100, 10, 100, 40);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
    [_smallView addSubview:loginButton];
    
    [self.view addSubview:_smallView];
    [loginButton release];
    [_smallView autorelease];
}

-(void)greatScrollandPage
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,320 , 400)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320 * [_dataSource count], 400);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 330, 300, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages =  [_dataSource count];
    _pageControl.enabled = NO;
    
    [_pageControl addTarget:self action:@selector(clickPageController:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];
    
    _currentPage = 0;
    [self reloadImage];
    [_scrollView autorelease];
    [_pageControl autorelease];
}

- (void)reloadImage
{
    _pageControl.currentPage = _currentPage;
    
    for (UIView *view in [_scrollView subviews]) {
        [view removeFromSuperview];
    }
    int prepage = [self getPage:_currentPage - 1];
    int nextPage = [self getPage:_currentPage +1];
    
    UIImage *image1 = [_dataSource objectAtIndex:prepage];
    UIImageView *preImageView = [[UIImageView alloc]initWithImage:image1];
    preImageView.frame = CGRectMake(0, 0, 320, 400);
    [_scrollView addSubview:preImageView];
    [preImageView release];
    
    UIImage *image2 = [_dataSource objectAtIndex:_currentPage];
    UIImageView *currentImageView = [[UIImageView alloc]initWithImage:image2];
    currentImageView.frame = CGRectMake(320, 0, 320, 400);
    [_scrollView addSubview:currentImageView];
    [currentImageView release];
    
    UIImage *image3 = [_dataSource objectAtIndex:nextPage];
    UIImageView *nextImageView = [[UIImageView alloc]initWithImage:image3];
    nextImageView.frame = CGRectMake(640, 0, 320, 400);
    [_scrollView addSubview:nextImageView];
    [nextImageView release];
    
    [_scrollView setContentOffset:CGPointMake(320, 0)];
    
}

- (NSInteger)getPage:(NSInteger)page
{
    if(page == [_dataSource count]){
        page = 0;
    }else if(page == -1){
        page = [_dataSource count]-1;
    }
    return page;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    if(x >= 640){
        _currentPage = [self getPage:_currentPage+1];
        [self reloadImage];
    }else if (x <= 0){
        _currentPage = [self getPage:_currentPage-1];
        [self reloadImage];
    }
}
//
//
-(void)loginView
{
    [UIView beginAnimations:@"fanzhuan" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:10 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_scrollView cache:YES];
    } completion:^(BOOL finished) {
        
        _scrollView.hidden = YES;
        _smallView.hidden = YES;
        
        [self greatLoginView];
        
    }];
    
    [UIView commitAnimations];
}

-(void)greatLoginView
{
    _loginView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,320 , 460)];
    _loginView.backgroundColor = [UIColor redColor];
    
    //logo头像
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 100, 50)];
    _logoImageView.backgroundColor = [UIColor brownColor];
    [_loginView addSubview:_logoImageView];
    
    //用户名
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    _nameTextField.placeholder = @"邮箱/用户名";
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_loginView addSubview:_nameTextField];
    
    //密码框
    _passTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 300, 30)];
    _passTextField.placeholder = @"密码";
    _passTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_loginView addSubview:_passTextField];
    
    //登录按钮
    UIButton *loginButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
    loginButton.frame = CGRectMake(10, 220, 300, 30);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:loginButton];
    [self.view addSubview:_loginView];
    
    [_logoImageView release];
    [_nameTextField release];
    [loginButton release];
    [_passTextField release];
    [_loginView release];
}

-(void)loginUser
{
    NSLog(@"登陆成功");
    
    _dataRequest = [[DataRequest alloc] init];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [_dataRequest sendWithError:self url:nil params:param success:nil error:nil method:@"POST"];
    WorktileViewController *worktile = [[WorktileViewController alloc] init];
    [self.navigationController pushViewController:worktile animated:YES];
    [worktile release];
    [param release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
