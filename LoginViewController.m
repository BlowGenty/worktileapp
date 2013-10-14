//
//  LoginViewController.m
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    _dataRequest = [[DataRequest alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:_nameTextField.text forKey:@"username"];
    [dict setObject:_passTextField.text forKey:@"password"];
    [dict setObject:@"POST" forKey:@"method"];
    //[ _dataRequest sendWithError:self url:<#(NSURL *)#> params:<#(NSDictionary *)#> success:<#(SEL)#> error:<#(SEL)#>];
    
    //logo头像
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 100, 50)];
    
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
    
    //用户名
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
    _nameTextField.placeholder = @"邮箱/用户名";
    [self.view addSubview:_nameTextField];
    
    //密码框
    _passTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 50)];
    _passTextField.placeholder = @"密码";
    [self.view addSubview:_passTextField];
    
    //登录按钮
    UIButton *loginButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
    loginButton.frame = CGRectMake(10, 150, 300, 50);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton release];
    
    
}

-(void)loginUser
{
    NSLog(@"登陆成功");
    NSDate *now = [NSDate date];
    float timeInterval = [now timeIntervalSinceNow];
    NSString *time = [NSString stringWithFormat:@"%f",timeInterval];
    
    [_dataRequest sendWithError:self url:nil params:nil success:nil error:nil method:@"POST" time:time];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
