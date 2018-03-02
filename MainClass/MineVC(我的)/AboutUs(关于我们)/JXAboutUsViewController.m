//
//  JXAboutUsViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAboutUsViewController.h"

@interface JXAboutUsViewController ()


@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLabel;

@end

@interface JXAboutUsViewController ()

@end

@implementation JXAboutUsViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self is_navigation];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.versionLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.copyrightLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_versionLabel setText:[JXRegular getAppVersion]];
}


- (void)is_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"关于我们";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 跳转APPSTORE
- (IBAction)oPenUrlAction:(UIButton *)sender { // ios
    
    [JXNetworkRequest asyncJumpAppStoreCompleted:^(NSDictionary *messagedic) {
        NSString *urls = messagedic[@"info"][@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urls]];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (IBAction)statementAction:(UIButton *)sender {
    
    JXWebAgreementViewController *web = [[JXWebAgreementViewController alloc] init];
    web.retweetType = 2;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
