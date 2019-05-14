//
//  ZXLCLLocationMgr.h
//  ZXLQYWechatinject
//
//  Created by 朱小亮 on 2017/7/3.
//  Copyright © 2017年 朱小亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


#define klatitudeuserdefault  @"klatitudeuserdefault"
#define klongitudeuserdefault  @"klongitudeuserdefault"

@interface ZXLCLLocationMgr : NSObject
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic)CLLocationDistance altitude;
@property (nonatomic)CLLocationAccuracy hAccuracy;
@property (nonatomic)CLLocationAccuracy vAccuracy;
@property (nonatomic)CLLocationDirection course;
@property (nonatomic)CLLocationSpeed speed;
+ (ZXLCLLocationMgr *)shareInstance;
- (void)showMsg:(NSString *)msg;
@end
