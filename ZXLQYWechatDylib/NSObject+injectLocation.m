//
//  NSObject+injectLocation.m
//  ZXLQYWechatinject
//
//  Created by 朱小亮 on 2017/7/3.
//  Copyright © 2017年 朱小亮. All rights reserved.
//

#import "NSObject+injectLocation.h"
#import "NSObject+__DyInjectSwizzle.h"
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import "ZXLCLLocationMgr.h"
#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "ZXLMapViewController.h"

@interface NSObject(qywechat)
@property (strong,nonatomic)UITableView *tableView;
@end


@implementation NSObject (injectLocation)

+ (void)load{
    if([NSStringFromClass([self class]) isEqualToString:@"SKUIMetricsAppLaunchEvent"]) return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self handleAction];
    });
}

+ (void)handleAction{
    Class mevc = NSClassFromString(@"WWKMeViewController");
    if (mevc) {
        
        NSLog(@"*********gogogogogo----------");
        [mevc ___exchangeMethod:@selector(viewDidLoad) withMethod:@selector(__dy_viewDidLoad)];
        [mevc ___exchangeMethod:@selector(tableView:numberOfRowsInSection:) withMethod:@selector(__dy_tableView:numberOfRowsInSection:)];
        [mevc ___exchangeMethod:@selector(tableView:cellForRowAtIndexPath:) withMethod:@selector(__dy_tableView:cellForRowAtIndexPath:)];
        [mevc ___exchangeMethod:@selector(tableView:heightForRowAtIndexPath:) withMethod:@selector(__dy_tableView:heightForRowAtIndexPath:)];
        [mevc ___exchangeMethod:@selector(tableView:didSelectRowAtIndexPath:) withMethod:@selector(__dy_tableView:didSelectRowAtIndexPath:)];
//        [mevc ___exchangeMethod:@selector(tableView:viewForFooterInSection:) withMethod:@selector(__dy_tableView:viewForFooterInSection:)];
//        [mevc ___exchangeMethod:@selector(tableView:heightForFooterInSection:) withMethod:@selector(__dy_tableView:heightForFooterInSection:)];
        
    }
    
    
    Class qmapView = NSClassFromString(@"QMapView");
    if (qmapView) {
        [qmapView ___exchangeMethod:@selector(locationManager:didUpdateToLocation:fromLocation:) withMethod:@selector(__dy_locationManager:didUpdateToLocation:fromLocation:)];
    }

}

- (void)__dy_viewDidLoad{
    
    [self __dy_viewDidLoad];
}


- (nullable UIView *)__dy_tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 120)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"此插件仅做技术交流\n严禁破坏公司纪律\n严禁干坏事\n违法必究\n后果自负";
        label.textColor = [UIColor redColor];
        self.tableView.tableFooterView = label;
        return label;
    }
   return  [self __dy_tableView:tableView viewForFooterInSection:section];
}

- (CGFloat)__dy_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {

        return 120;
    }
    return  [self __dy_tableView:tableView heightForFooterInSection:section];
}


- (BOOL)__dy_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSClassFromString(@"UIDebuggingInformationOverlay") performSelector:@selector(prepareDebuggingOverlay)];
   
    return  [self __dy_application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)__dy_locationManager:(CLLocationManager *)arg1 didUpdateToLocation:(CLLocation *)arg2 fromLocation:(CLLocation *)arg3{
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"CLLocationCoordinate2DOpen"] == 1){
//         NSString *msgBegin = [NSString stringWithFormat:@"-------------begin:%f,%f,%f,%f,%f,%f,%f",arg2.coordinate.latitude,arg2.coordinate.longitude,arg2.altitude,arg2.horizontalAccuracy,arg2.verticalAccuracy,arg2.course,arg2.speed];
        ZXLCLLocationMgr *mgr = [ZXLCLLocationMgr shareInstance];
        CLLocation *location = [[CLLocation alloc] initWithCoordinate:[mgr coordinate] altitude:arg2.altitude horizontalAccuracy:mgr.hAccuracy verticalAccuracy:mgr.vAccuracy timestamp:arg2.timestamp];
//        NSString *msgAfter = [NSString stringWithFormat:@"-------------after:%f,%f,%f,%f,%f,%f,%f",location.coordinate.latitude,location.coordinate.longitude,location.altitude,location.horizontalAccuracy,location.verticalAccuracy,location.course,location.speed];
//        [[ZXLCLLocationMgr shareInstance] showMsg:[NSString stringWithFormat:@"%@ \n %@",msgBegin,msgAfter]];
        [self __dy_locationManager:arg1 didUpdateToLocation:location fromLocation:arg3];
    }
    else{
//        [[ZXLCLLocationMgr shareInstance] showMsg:NSStringFromSelector(_cmd)];
         [self __dy_locationManager:arg1 didUpdateToLocation:arg2 fromLocation:arg3];
    }
    
}

- (double)__dy_tableView:(id)arg1 heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 44;
    }
    return [self __dy_tableView:arg1 heightForRowAtIndexPath:indexPath];
}

- (long long)__dy_tableView:(id)arg1 numberOfRowsInSection:(NSInteger)arg2{
    if (arg2 == 1) {
        return 2;
    }
    return [self __dy_tableView:arg1 numberOfRowsInSection:arg2];
}

- (void)__dy_tableView:(id)arg1 didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
//        [self openGaoDeMap];
        ZXLMapViewController *vc = [ZXLMapViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [[(UIViewController *)self navigationController] pushViewController:vc animated:YES];
        return;
    }
    [self __dy_tableView:arg1 didSelectRowAtIndexPath:indexPath];
}

- (id)__dy_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"swithchTempIdentifiler"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"swithchTempIdentifiler"];
        }
        cell.imageView.image = [UIImage imageNamed:@"AppIcon29x29@2x"];
        cell.textLabel.text = @"打卡定位公司开关";
        UISwitch *aSwitch = [UISwitch new];
        [aSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = aSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"CLLocationCoordinate2DOpen"] == 1){
            aSwitch.on = YES;
        }
        else{
            aSwitch.on = NO;
        }
        return cell;
    }
    
    
    
    return [self __dy_tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (void)switchChange:(UISwitch *)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:sender.on?1:0 forKey:@"CLLocationCoordinate2DOpen"];
}


-(void)openGaoDeMap{
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2",@"app name", @"YGche", @"终点", @"", @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}



@end
