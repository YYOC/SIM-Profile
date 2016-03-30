//
//  ViewController.m
//  SIM
//
//  Created by 杨 on 15/5/19.
//  Copyright (c) 2015年 杨. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    
    //声明变量
    
    CTTelephonyNetworkInfo *networkInfo;
    UITableView *_tableViw;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableViw = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableViw.delegate = self;
    _tableViw.dataSource = self;
    [self.view addSubview:_tableViw];
    
    _tableViw.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    //初始化
    
    networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    //当sim卡更换时弹出此窗口
    
    networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sim card changed" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [alert show];
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    //获取sim卡信息
    
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    switch (indexPath.row) {
            
        case 0://供应商名称（中国联通 中国移动）
            
            cell.textLabel.text = @"carrierName";
            
            cell.detailTextLabel.text = carrier.carrierName;
            
            break;
            
        case 1://所在国家编号
            
            cell.textLabel.text = @"mobileCountryCode";
            
            cell.detailTextLabel.text = carrier.mobileCountryCode;
            
            break;
            
        case 2://供应商网络编号
            
            cell.textLabel.text = @"mobileNetworkCode";
            
            cell.detailTextLabel.text = carrier.mobileNetworkCode;
            
            break;
            
        case 3:
            
            cell.textLabel.text = @"isoCountryCode";
            
            cell.detailTextLabel.text = carrier.isoCountryCode;
            
            break;
            
        case 4://是否允许voip
            
            cell.textLabel.text = @"allowsVOIP";
            
            cell.detailTextLabel.text = carrier.allowsVOIP?@"YES":@"NO";
            
            break;
            
            
        default:
            
            break;
            
    }
    
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
