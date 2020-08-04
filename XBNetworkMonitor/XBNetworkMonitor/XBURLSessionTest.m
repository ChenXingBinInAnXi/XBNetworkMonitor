//
//  XBURLSessionTest.m
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/6.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import "XBURLSessionTest.h"


@interface XBURLSessionTest()<NSURLSessionDataDelegate>
//
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSURLSessionDataTask *task;
@property(nonatomic,strong) NSMutableData *multData;
@end

@implementation XBURLSessionTest


//address==https://www.jingyu.com/jyApi/moreData
//2019-06-10 15:37:31.514196+0800 XSYDDQReader[13652:3671644] params===={
//    "id" : 1,
//    "distinct_id" : "50907FE5-46D8-43B4-83A7-5557B08DEA4C",
//    "sex" : 1,
//    "channel" : "hyapp1000",
//    "idfa" : "C0E9831A-4928-4C87-9D03-0616D985E2B7",
//    "$referrer" : "CYBookshelfViewController",
//    "interfaceCode" : 203,
//    "isMore" : 1,
//    "portal_type" : 0,
//    "versionName" : "2.0.2",
//    "osType" : 1,
//    "refresh" : 0,
//    "versionCode" : "7",
//    "$screen_name" : "CYComicsCityViewController",
//    "userKey" : "50907FE5-46D8-43B4-83A7-5557B08DEA4C",
//    "pageType" : 1,
//    "appKey" : "201020412",
//    "suggestId" : "0",
//    "gender" : 1
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    return self;
}


-(void)startNetwork{
    NSLog(@"----------------startNetwork");
    NSString *urlStr = [NSString stringWithFormat:@"https://www.jingyu.com/jyApi/moreData?id=1&distinct_id=50907FE5-46D8-43B4-83A7-5557B08DEA4C&sex=1&channel=hyapp1000&idfa=C0E9831A-4928-4C87-9D03-0616D985E2B7&interfaceCode=203&isMore=1&portal_type=0&versionName=2.0.2&osType=1&refresh=0&versionCode=7&userKey=50907FE5-46D8-43B4-83A7-5557B08DEA4C&pageType=1&appKey=201020412&suggestId=0&gender=1"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    self.multData = nil;
    
    [task resume];
}

//params===={
//    "id" : "7282879",
//    "distinct_id" : "FB1FD40E-87BB-41B0-AA8D-750F1A1E3865",
//    "sex" : 1,
//    "channel" : "jlappi2140",
//    "idfa" : "C0E9831A-4928-4C87-9D03-0616D985E2B7",
//    "$referrer" : "CYNewBookCityViewController",
//    "interfaceCode" : 301,
//    "portal_type" : 0,
//    "versionName" : "1.0.2",
//    "osType" : 1,
//    "versionCode" : "1",
//    "$screen_name" : "CYBookDetailViewController",
//    "userKey" : "FB1FD40E-87BB-41B0-AA8D-750F1A1E3865",
//    "appKey" : "201020412",
//    "_cs" : "25"
//}

-(void)startNet2{
    NSString *urlStr = [NSString stringWithFormat:@"http://www.jinlizhuishu.com/api/bookinfo/info?id=7282879&distinct_id=FB1FD40E-87BB-41B0-AA8D-750F1A1E3865&sex=1&channel=jlappi2140&idfa=C0E9831A-4928-4C87-9D03-0616D985E2B7&interfaceCode=301&isMore=1&portal_type=0&versionName=1.0.2&osType=1&versionCode=1&userKey=FB1FD40E-87BB-41B0-AA8D-750F1A1E3865&appKey=201020412&_cs=25"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    self.multData = nil;
    
    [task resume];
}

-(void)stopNetwork{
}


#pragma mark -Delegate
//TCP建立连接时间
//DNS 时间
//SSL 时间
//首包时间
//响应时间
//HTTP错误率
//网络错误率

//NSURLSessionTaskMetricsResourceFetchTypeUnknown,
//NSURLSessionTaskMetricsResourceFetchTypeNetworkLoad,   /* The resource was loaded over the network. */
//NSURLSessionTaskMetricsResourceFetchTypeServerPush,    /* The resource was pushed by the server to the client. */
//NSURLSessionTaskMetricsResourceFetchTypeLocalCache,
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics API_AVAILABLE(ios(10.0)){
    NSLog(@"--------------------------------------");
    NSLog(@"count===%lu",(unsigned long)metrics.transactionMetrics.count);
    for(NSURLSessionTaskTransactionMetrics *me in metrics.transactionMetrics){
        NSLog(@"me===%ld",(long)me.resourceFetchType);
        NSLog(@"resuse==%d",me.isReusedConnection);
    }
    NSLog(@"1-------------------------------------");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    [self.multData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
//    NSLog(@"didCompleteWithError==%@", [NSJSONSerialization JSONObjectWithData:self.multData.copy options:NSJSONReadingMutableLeaves error:nil]);
    NSLog(@"taskId=%lu",(unsigned long)task.taskIdentifier);
}



#pragma mark Get
-(NSMutableData *)multData{
    if (_multData == nil) {
        _multData = [NSMutableData data];
    }
    return _multData;
}

@end
