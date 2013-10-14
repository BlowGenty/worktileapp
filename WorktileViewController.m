//
//  WorktileViewController.m
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "WorktileViewController.h"
#import "WorktileJobViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GMGridViewLayoutStrategies.h"

@interface WorktileViewController ()

@end

@implementation WorktileViewController

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
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithWhite:16514043 alpha:1];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor colorWithWhite:16514043 alpha:1];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 30)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"工作台";
    nameLabel.textColor = [UIColor redColor];
    [view addSubview:nameLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
    imageView.backgroundColor = [UIColor redColor];
    CALayer *layer = imageView.layer;
    //获取ImageView的层
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:15.0];
    [view addSubview:imageView];
    [self.view addSubview:view];
    
    [nameLabel release];
    [imageView release];
    
    
//    
    //把图片装到数组里
    _dataSource = [[NSMutableArray alloc] init];
    for (int i=1; i<=7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [_dataSource addObject:image];
    }
    [_dataSource autorelease];
    _currentPage = 0;
    [self greatScrollandPage];
}

-(void)greatScrollandPage
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50,320 , 460)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
//    if ([_dataSource count] % 6 == 0) {
//        _scrollView.contentSize = CGSizeMake([_dataSource count] / 6 * 320, 460);
//    }else if([_dataSource count] % 6 != 0){
//        _scrollView.contentSize = CGSizeMake( ([_dataSource count]/ 6 +1) * 320 , 460);
//    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, 300, 20)];
    _pageControl.currentPage = 0;
    if ([_dataSource count] % 6 == 0) {
        _pageControl.numberOfPages = [_dataSource count] / 6;
    }else{
        _pageControl.numberOfPages = [_dataSource count] / 6 + 1;
    }
    
    _pageControl.enabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    [_pageControl addTarget:self action:@selector(clickPageController:) forControlEvents:UIControlEventValueChanged];
    
    _gridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 400 )];
    _gridView.dataSource = self;
    _gridView.actionDelegate = self;
    _gridView.sortingDelegate = self;
    _gridView.clipsToBounds = YES;
    _gridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    [_scrollView addSubview:_gridView];
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];
    
    //_scrollView.contentOffset = CGPointMake(0, 0);
    
    [_scrollView autorelease];
    [_pageControl autorelease];
}




- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_dataSource count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(150, 100);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell = [[GMGridViewCell alloc] initWithFrame:CGRectNull];


    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.frame = CGRectMake(0, 0, 150, 100);
    imageView.image = [_dataSource objectAtIndex:index];
    cell.contentView =imageView;
    [imageView release];
    return cell;
}
//
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    WorktileJobViewController *job = [[WorktileJobViewController alloc] init];
    [self.navigationController pushViewController:job animated:YES];
    [job release];
    
}

-(void)GMGridView:(GMGridView *)gridView changedEdit:(BOOL)edit
{
    
}

-(void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    
}

//当拖动开始时

-(void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
