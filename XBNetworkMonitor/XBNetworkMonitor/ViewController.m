//
//  ViewController.m
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/6.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import "ViewController.h"
#import "XBURLSessionTest.h"
#import <AdSupport/ASIdentifierManager.h>


@interface ViewController ()

@property(nonatomic,strong) XBURLSessionTest *sessionTest;
@property(nonatomic,assign) int selected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sessionTest = [XBURLSessionTest new];
    self.selected = 0;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.selected == 0) {
        [self.sessionTest startNetwork];
    }else if (self.selected == 1){
           [self.sessionTest startNet2];
    }
    self.selected = !self.selected;
    
//    [self.sessionTest startNetwork];
}

@end
