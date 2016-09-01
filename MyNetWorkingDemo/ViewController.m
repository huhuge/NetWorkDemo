//
//  ViewController.m
//  MyNetWorkingDemo
//
//  Created by JeroMac on 16/7/13.
//  Copyright © 2016年 HMZ. All rights reserved.
//

#import "ViewController.h"
#import "HYPicModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)testAction:(UIButton *)sender {
    NSLog(@"test");
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"departmentName"];
    [dic setObject:@"2" forKey:@"coordinateContent"];
    [dic setObject:@"3" forKey:@"departmentId"];
    [ShowMessage showLoadingData:self.view strMessage:@"提交中..."];
    
    
    ////post
    [[HYHttp sharedHYHttp]POST:@"http://123.57.16.134:8083/tairui/applyCoordinateAction!doSave.action" parameters:dic success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[responseObject objectForKey:@"success"] integerValue]==1) {
            [ShowMessage showTextOnly:@"提交成功" messageView:self.view];
        }else{
            [ShowMessage showTextOnly:[responseObject objectForKey:@"obj"] messageView:self.view];
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"提交失败" messageView:self.view];
        
    }];
    
    
    ////get
    [[HYHttp sharedHYHttp]GET:@"http://www.acbb.cc/carmanagerservice/interface?method=queryAdvertisments&position=1" parameters:dic success:^(id  _Nonnull responseObject) {
        
        [ShowMessage showTextOnly:@"加载成功" messageView:self.view];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    ////post上传图片
    HYPicModel *model = [[HYPicModel alloc]init];
    model.pic = [UIImage imageNamed:@""];
    model.picData = nil;
    model.picName = @"attachments";
    model.url = @"";
    [ShowMessage showLoadingData:self.view strMessage:@"提交中..."];
    [[HYHttp sharedHYHttp]POST:@"http://123.57.16.134:8083/tairui/applyArticleAction!doSave.action" parameters:dic andPic:model progress:nil success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"成功=%@",responseObject);
        [ShowMessage showTextOnly:@"提交成功" messageView:self.view];
        
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ShowMessage showTextOnly:@"提交失败" messageView:self.view];
        NSLog(@"失败=%@",error);
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
