//
//  DataRequest.h
//  SouZhouBian_iPhone
//
//  Created by 神州数码 on 13-8-25.
//  Copyright (c) 2013年 神州数码. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

@interface DataRequest : NSObject
{
    SEL _requestSuccess;
    
    SEL _requestError;
    
    id _delegate;
}
@property(strong, nonatomic)ASIHTTPRequest* req;

@property(strong, nonatomic)NSDictionary *reqParam;

-(void)sendWithError:(id)delegate url:(NSURL *)url params:(NSDictionary *)params success:(SEL)requestSuccess error:(SEL)requestError method:(NSString *)requestMethod;

- (void)sendWithPushToken:(NSData *)toKen delegate:(id)delegate url:(NSURL *)url;

//+(void)requestSuccess:(ASIHTTPRequest * )request;
//
//+(void)requestError;

@end
