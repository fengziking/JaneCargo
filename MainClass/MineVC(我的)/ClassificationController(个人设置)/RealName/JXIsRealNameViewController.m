//
//  JXIsRealNameViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXIsRealNameViewController.h"




@interface JXIsRealNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *identitylabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXIsRealNameViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self y_request];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"用户实名认证";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)y_request {

    [JXNetworkRequest asyncObtainCertificationCompleted:^(NSDictionary *messagedic) {
        
        NSString *strname = [messagedic[@"info"][@"realname"] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
        self.namelabel.text = strname;
        self.identitylabel.text = messagedic[@"info"][@"noid"];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}



- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
