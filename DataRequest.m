//
//  DataRequest.m
//  SouZhouBian_iPhone
//
//  Created by 神州数码 on 13-8-25.
//  Copyright (c) 2013年 神州数码. All rights reserved.
//

#import "DataRequest.h"
#import "KeychainItemWrapper.h"
#import <CommonCrypto/CommonDigest.h>
#import "MyMD5.h"
#import "ASIFormDataRequest.h"


#define APP_KEY @"12bed94c25c8df"
#define APP_SECRET @"e2ff8e8d03c268"
#define CLIENT_VERSION @"1"
#define STORE_FROM @"1"
#define VERSION @"2.0"


@implementation DataRequest
@synthesize req;
@synthesize reqParam;

-(id)init
{
    self = [super init];
    if(self)
    {
        req = nil;
    }
    return self;
}
- (void)sendWithPushToken:(NSData *)toKen delegate:(id)delegate url:(NSURL *)url 
{
    [self cacelRequest];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    self.req = request;
    
    self.req.delegate = self;
    
    [self.req appendPostData:toKen];
    
    //[self.req setRequestMethod:@"POST"];

    _delegate = delegate;
    
    [self.req setDidFinishSelector:@selector(theRequestSuccess:)];
    
    [self.req setDidFailSelector:@selector(theRequestError:)];

    //开始异步请求
    [self.req startAsynchronous];    
}
-(void)sendWithError:(id)delegate url:(NSURL *)url params:(NSDictionary *)params success:(SEL)theRequestSuccess error:(SEL)theRequestError method:(NSString *)requestMethod
{
//    NSURL * dataUrl = [NSURL URLWithString:url];
    
    [self cacelRequest];
    
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //设置代理
    self.req = request;
    [self.req setAllowCompressedResponse:YES];
    [self.req setValidatesSecureCertificate:NO];
    self.req.delegate = self;
    [self.req setRequestMethod:requestMethod];
     
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:@"YOUR_APP_ID_HERE.com.yourcompany.AppIdentifier"];
    
    int index = arc4random() % 10;
    NSString *indexString = [NSString stringWithFormat:@"%d",index];
    const char *cStr = [indexString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSString *stringRoud = [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    NSLog(@"stringRound %@",stringRoud);
    //保存数据
    //[wrapper setObject:@"<帐号>" forKey:(id)kSecAttrAccount];
    [wrapper setObject:stringRoud forKey:(id)kSecValueData];
    //[wrapper setObject:stringRoud forKey:@"stringRound"];
    //从keychain里取出帐号密码
    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    
    //清空设置
    [wrapper resetKeychainItem];
    
    //设置请求成功的回调方法，也可设置失败方法didFailSelector，如果调用失败方法，说明未成功，方便自己进行调试和处理
  //  [self.req appendPostData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    NSString *method = [NSString stringWithFormat:@"%@",requestMethod];
    NSString *app_key = [NSString stringWithFormat:@"%@",APP_KEY];
    NSString *cv = [NSString stringWithFormat:@"%@",CLIENT_VERSION];
    NSString *device = [NSString stringWithFormat:@"%@",password];
    NSString *store = [NSString stringWithFormat:@"%@",STORE_FROM];
    NSString *timeInterval = [NSString stringWithFormat:@"%@",timeString];
    NSString *version = [NSString stringWithFormat:@"%@",VERSION];
    NSString *secret = [NSString stringWithFormat:@"%@",APP_SECRET];
    
    NSString *strings = [NSString stringWithFormat:@"%@""&app_key=""%@""&client_version=""%@""&device_id=""%@""&store_from=""%@""&timestamp=""%@""&version=""%@""%@",method,app_key,cv,device,store,timeInterval,version,secret];
    
    NSLog(@"strings %@",strings);

    NSString *stringData = [MyMD5 md5:strings];
    
    NSLog(@"stringData %@",stringData);
    
    NSString *signatureValue = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[stringData substringWithRange:NSMakeRange(0, 1)],[stringData substringWithRange:NSMakeRange(10, 1)],[stringData substringWithRange:NSMakeRange(4, 1)],[stringData substringWithRange:NSMakeRange(5, 1)],[stringData substringWithRange:NSMakeRange(22, 1)],[stringData substringWithRange:NSMakeRange(18, 1)],[stringData substringWithRange:NSMakeRange(16, 1)],[stringData substringWithRange:NSMakeRange(8, 1)]];
    
    NSLog(@"stringFormat %@",signatureValue);
    

    NSMutableDictionary *paramItems = [[NSMutableDictionary alloc] init];
    if (params) {
        [paramItems addEntriesFromDictionary:params];
    }
    
    [paramItems setObject:APP_KEY forKey:@"app_key"];
    [paramItems setObject:CLIENT_VERSION forKey:@"client_version"];
    [paramItems setObject:password forKey:@"device_id"];
    [paramItems setObject:STORE_FROM forKey:@"store_from"];
    [paramItems setObject:timeInterval forKey:@"timestamp"];
    [paramItems setObject:VERSION forKey:@"version"];
    [paramItems setObject:signatureValue forKey:@"signature"];
    
    [paramItems enumerateKeysAndObjectsUsingBlock:
     ^(id key, id value, BOOL *stop) {
         [request addRequestHeader:key value:value];
     }];
    
    NSLog(@"head %@",paramItems);
    
    _requestSuccess = theRequestSuccess;
    
    _requestError = theRequestError;
    
    _delegate = delegate;
    
    [self.req setDidFinishSelector:@selector(theRequestSuccess:)];
    
    [self.req setDidFailSelector:@selector(theRequestError:)];
    
//    request.didFinishSelector = @selector(requestSuccess:);
    
//    request.didFailSelector = @selector(requestError);
    //开始异步请求
    [self.req startAsynchronous];
}


-(void)theRequestSuccess:(ASIHTTPRequest * )request
{
//    NSLog(@"requestSuccess");
    @try {
        [_delegate performSelector:_requestSuccess withObject:request];
    }
    @catch (NSException *exception) {
        NSLog(@"SendWithError RequestSuccess Exception %@", [exception debugDescription]);
    }
//    [_delegate performSelector:_requestSuccess withObject:nil];
    
    //停掉当前的request    
    NSLog(@"reqeustsuccess");

}

-(void)requestError: (ASIHTTPRequest *)request
{
    if(_delegate &&([_delegate respondsToSelector:_requestError]))
    {
        
        [_delegate performSelector:_requestError withObject:request];
    }else {
        NSLog(@"error:%@ errorCode:%d", request.error, [request responseStatusCode]);
    }
}
-(void)cacelRequest
{
    if(self.req)
    {
        [self.req clearDelegatesAndCancel];
    }
}
@end
