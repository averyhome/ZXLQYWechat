//
//  ZXLMapViewController.m
//  ZXLQYWechat
//
//  Created by 朱小亮 on 2017/10/31.
//  Copyright © 2017年 朱小亮. All rights reserved.
//

#import "ZXLMapViewController.h"
#import <MapKit/MapKit.h>
#import "ZXLCLLocationMgr.h"

@interface ZXLMapViewController ()<MKMapViewDelegate>
@property (strong,nonatomic)MKMapView *mapView;
@property (strong,nonatomic)MKPointAnnotation *tempAnno;
@property (strong,nonatomic)MKPointAnnotation *resultAnno;
@end

@implementation ZXLMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"%.5f,%.5f",[ZXLCLLocationMgr shareInstance].coordinate.latitude,[ZXLCLLocationMgr shareInstance].coordinate.longitude];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
//    self.mapView.delegate = self;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    self.resultAnno=[[MKPointAnnotation alloc]init];
    self.resultAnno.coordinate = [ZXLCLLocationMgr shareInstance].coordinate;
    self.resultAnno.title = @"你想要的位置";
    [self.mapView addAnnotation:self.resultAnno];
    
    self.tempAnno=[[MKPointAnnotation alloc]init];
    [self.mapView addAnnotation:self.tempAnno];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(okTheCoordinate:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //    判断是不是用户的大头针数据模型
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    

    
    // 创建MKAnnotationView
    static NSString *ID = @"you want";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        annoView.canShowCallout = YES;
    }
    annoView.image = [UIImage imageNamed:@"location"];
    return annoView;

}

- (void)okTheCoordinate:(id)sender {
    self.resultAnno.coordinate = self.tempAnno.coordinate;
    self.resultAnno.title = @"你想要的位置";
    [self.mapView removeAnnotation:self.tempAnno];
    [[NSUserDefaults standardUserDefaults] setDouble:self.resultAnno.coordinate.latitude forKey:klatitudeuserdefault];
    [[NSUserDefaults standardUserDefaults] setDouble:self.resultAnno.coordinate.longitude forKey:klongitudeuserdefault];
    self.title = [NSString stringWithFormat:@"%.5f,%.5f",[ZXLCLLocationMgr shareInstance].coordinate.latitude,[ZXLCLLocationMgr shareInstance].coordinate.longitude];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self.mapView];
    CLLocationCoordinate2D coordinate=[self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    self.tempAnno.title = @"your touch point";
    [self.mapView addAnnotation:self.tempAnno];
    self.tempAnno.coordinate=coordinate;
 
}


@end
