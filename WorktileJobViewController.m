//
//  WorktileJobViewController.m
//  WorktileProduct
//
//  Created by TerryLee on 13-9-19.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "WorktileJobViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QCheckBox.h"

@interface WorktileJobViewController ()

@end

@implementation WorktileJobViewController

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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor colorWithWhite:16514043 alpha:1];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 30)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"Worktile开发";
    nameLabel.textColor = [UIColor redColor];
    [view addSubview:nameLabel];
    [self.view addSubview:view];
    [view release];

    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataList" ofType:@"plist"];
    
    _dataSource = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    _allSheng = [[NSArray alloc] initWithArray:[_dataSource allKeys]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 430)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = NO;
    _scrollView.contentSize = CGSizeMake([_allSheng count] * 320, 380);
    //_scrollView.directionalLockEnabled = YES;

    [self.view addSubview:_scrollView];
    
    _currentPage = 0;
    [self scrollViewPage];
    [_scrollView autorelease];
}

-(void)scrollViewPage
{
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 430)];
    _view1.backgroundColor = [UIColor yellowColor];
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(15, 10, 290, 380) style:UITableViewStyleGrouped];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    [_view1 addSubview:_tableView1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(320, 30, 320, 430)];
    _view2.backgroundColor = [UIColor blueColor];
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(15, 10, 290, 380) style:UITableViewStyleGrouped];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    [_view2 addSubview:_tableView2];
    
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(640, 30, 320, 430)];
    _view3.backgroundColor = [UIColor yellowColor];
    _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(15, 10, 290, 380) style:UITableViewStyleGrouped];
    _tableView3.delegate = self;
    _tableView3.dataSource = self;
    [_view3 addSubview:_tableView3];
    
    [_scrollView addSubview:_view1];
    [_scrollView addSubview:_view2];
    [_scrollView addSubview:_view3];
    _scrollView.contentOffset = CGPointMake(0, 0);
    [_tableView1 autorelease];
    [_tableView2 autorelease];
    [_tableView3 autorelease];
    [_view1 autorelease];
    [_view2 autorelease];
    [_view3 autorelease];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _tableView1) {
         _allShi = [_dataSource objectForKey:[_allSheng objectAtIndex:0]] ;
    }else if(tableView == _tableView2){
        _allShi = [_dataSource objectForKey:[_allSheng objectAtIndex:1]] ;
    }else if(tableView == _tableView3){
        _allShi = [_dataSource objectForKey:[_allSheng objectAtIndex:2]] ;
    }
   
    return [_allShi count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView1) {
        section = 0;
    }else if(tableView == _tableView2){
        section = 1;
    }else if(tableView == _tableView3){
        section = 2;
    }

    return [_allSheng objectAtIndex:section];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellString];
    }
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(220, 30, 30, 30)];
    CALayer *l = [imageview layer];   //获取ImageView的层
    [l setMasksToBounds:YES];
    [l setCornerRadius:15.0];

    imageview.image = [UIImage imageNamed:@"1.jpg"];
    [cell.contentView addSubview:imageview];
    [imageview autorelease];
    
    if (tableView == _tableView1) {
        //得到一个省
        NSString *sheng = [_allSheng objectAtIndex:0];
        //得到每个省的所有的市
        _city = [_dataSource objectForKey:sheng];

    }else if (tableView == _tableView2){
        //得到一个省
        NSString *sheng = [_allSheng objectAtIndex:1];
        //得到每个省的所有的市
        _city = [_dataSource objectForKey:sheng];

    }else if (tableView == _tableView3){
        //得到一个省
        NSString *sheng = [_allSheng objectAtIndex:2];
        //得到每个省的所有的市
        _city = [_dataSource objectForKey:sheng];

    }
    
    
   // cell.textLabel.text = [city objectAtIndex:indexPath.row];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 50, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.text = @"label";
    //cell.detailTextLabel.text = @"label";
    [cell.contentView addSubview:textField];
    
    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(10, 10, 80, 40);
    [_check1 setTitle:[_city  objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [cell.contentView addSubview:_check1];
    [_check1 setChecked:NO];
    [_check1 release];
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

     _currentPage = _scrollView.contentOffset.x + 320 ;
    

}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)dealloc
{
    [super dealloc];
    [_allShi release];
    [_allSheng release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
