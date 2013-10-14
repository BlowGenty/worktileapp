//
//  LoginViewController.h
//  WorktileProduct
//
//  Created by TerryLee on 13-9-18.
//  Copyright (c) 2013年 TerryLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataRequest.h"


@interface LoginViewController : UIViewController

{
    UIImageView *_imageView;
    
    UITextField *_nameTextField;
    
    UITextField *_passTextField;
    DataRequest *_dataRequest;
    
}


@end
