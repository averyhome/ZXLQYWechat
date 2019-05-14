//
//  ZXLCLLocationMgr.m
//  ZXLQYWechatinject
//
//  Created by 朱小亮 on 2017/7/3.
//  Copyright © 2017年 朱小亮. All rights reserved.
//

#import "ZXLCLLocationMgr.h"
#import <UIKit/UIKit.h>

/*
 ##########:30.549238/n1111************:114.203605
 */


/*
 -------------begin:30.549091,114.203294,38.823914,1414.000000,18.871010,-1.000000,-1.000000
 -------------after:30.549238,114.203605,38.823914,1414.000000,18.871010,-1.000000,-1.000000
 */

@interface ZXLCLLocationMgr()
@property(strong,nonatomic)UILabel *label;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation ZXLCLLocationMgr

+ (id)shareInstance{
    static ZXLCLLocationMgr *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [ZXLCLLocationMgr new];
//        double random = arc4random()%10000 *0.0001;
//        mgr.coordinate = CLLocationCoordinate2DMake(30.549238 + random, 114.203605 + random);
        mgr.altitude = 38.823914;
        mgr.hAccuracy = 1414.000000;
        mgr.vAccuracy = 18.871010;
        mgr.course = -1.000000;
        mgr.speed = -1.000000;
    });
    return mgr;
}

- (CLLocationCoordinate2D)coordinate{
//    double random = arc4random()%100 * (arc4random()%1 == 1?0.000001:-0.000001);
////    random = 0;
//     return  CLLocationCoordinate2DMake(30.549238 + random, 114.203605 + random);
//    return  CLLocationCoordinate2DMake(50.549238 + random, 914.203605 + random);
    
    double random = arc4random()%100 * (arc4random()%1 == 1?0.000001:-0.000001);
    //    random = 0;
    return  CLLocationCoordinate2DMake([[NSUserDefaults standardUserDefaults] doubleForKey:klatitudeuserdefault] + random, [[NSUserDefaults standardUserDefaults] doubleForKey:klongitudeuserdefault] + random);
}


- (void)showMsg:(NSString *)msg{
    UIWindow *window = [self mainWindow];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self.label removeFromSuperview];
    }
    if (!self.label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
    }
    self.label.numberOfLines = 0 ;
    self.label.text = msg;
    [window addSubview:self.label];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.label removeFromSuperview];
    }];
}
//获取当前window
- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

@end
