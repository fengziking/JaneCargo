//
//  JXGoodsSearchViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodsSearchViewController.h"
#import "UIView+Location.h"
#import "JXDeletehisTableViewCell.h"
#import "JXHisRecordTableViewCell.h"
// 进入二级搜索结果
#import "JXSearchGoodViewController.h"
#import "JXRecordingView.h"

#import "IATConfig.h"
#import "ISRDataHelper.h"

typedef void(^AZXHeightCallBack)(CGFloat height);
@interface JXGoodsSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SFSpeechRecognizerDelegate>
/** tableView*/
@property(strong,nonatomic) UITableView *tableView;
/** 搜索框*/
@property(strong,nonatomic) UISearchBar *searchBar;
/** 占位文字*/
@property(copy,nonatomic) NSString *placeHolder;

/** 热门搜索String Array*/
@property(strong,nonatomic) NSMutableArray *hotKeywordsArray;
/** 历史搜索String Array*/
@property(strong,nonatomic) NSArray *historyKeywordsArray;
/** 搜索结果StringArray*/
@property(copy,nonatomic) NSArray *resultArray;
/** 热门搜索Btns*/
@property(strong,nonatomic) NSMutableArray *hotKeywordsBtnArray;
/** 历史搜索Btns*/
@property(strong,nonatomic) NSMutableArray *historyKeywordsBtnArray;
/** 是有有搜索结果 */
//@property(assign,nonatomic,getter=hasResult) BOOL result;
/** 是否点击了搜索 */
@property(assign,nonatomic,getter=isSearching) BOOL searching;
// 搜索记录
@property (nonatomic, strong) NSMutableArray *searchrecordsArray;
@property (nonatomic, strong) NSMutableArray *dateArray;
// 语音
//@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
//@property (nonatomic,strong) AVAudioEngine *audioEngine;
//@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
//@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@property (nonatomic, strong) UIButton *recordButton;
// 语音遮罩
@property (nonatomic, strong) UIView *voiceMask;

@end

@implementation JXGoodsSearchViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self initRecognizer];//初始化识别对象
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //初始化录音器
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //不保存录音文件
        
    }else  {//有界面
        
        //单例模式，UI的实例
        if (_iflyRecognizerView == nil) {
            //UI显示剧中
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
            
            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
            
        }
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //设置最长录音时间
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        [_iFlySpeechRecognizer cancel]; //取消识别
        [_iFlySpeechRecognizer setDelegate:nil];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        [_pcmRecorder stop];
        _pcmRecorder.delegate = nil;
    }
    else
    {
        [_iflyRecognizerView cancel]; //取消识别
        [_iflyRecognizerView setDelegate:nil];
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    }
    
    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupNav];
    [self searchHot];
    self.uploader = [[IFlyDataUploader alloc] init];
    //demo录音文件保存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc] initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];
    
    
    
}

// 热搜
- (void)searchHot {
    
    self.hotKeywordsArray = @[].mutableCopy;
    self.searchrecordsArray = @[].mutableCopy;
    [JXNetworkRequest asyncSearchForHotis_Cache:YES refreshCache:NO completed:^(NSDictionary *messagedic) {
        
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infordic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infordic];
            [self.hotKeywordsArray addObject:model];
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
    // 搜索记录
    [JXNetworkRequest asyncSearchRecordsis_Cache:YES refreshCache:NO localdata:^(NSArray *messagedic) {
        // 本地数据
        self.searchrecordsArray = [NSMutableArray arrayWithArray:messagedic];
        [self.tableView reloadData];
    } completed:^(NSDictionary *messagedic) {
        // 数据库数据
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infordic in infoArray) {
            [self.searchrecordsArray addObject:infordic[@"keyword"]];
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}


#pragma mark - 初始化
- (void)setupBasic {
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self sethideKeyBoardAccessoryView];
    
    _voiceMask = [[UIView alloc] initWithFrame:self.tableView.frame];
    _voiceMask.alpha = 0.9f;
    [_voiceMask setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self.view addSubview:_voiceMask];
    
    UIView *imagegif = [[UIView alloc] initWithFrame:CGRectMake((_voiceMask.frame.size.width-120)/2, 70+64, 120, 120)];
    [_voiceMask addSubview:imagegif];
    
    NSString  *name = @"imgvoice.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImageView *loadingImageView = [[UIImageView alloc]init];
    loadingImageView.backgroundColor = [UIColor clearColor];
    loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    loadingImageView.frame = CGRectMake(0, 0, 120, 120);
    [imagegif addSubview:loadingImageView];
    [self hiddenVoice];
    
}

// 关闭遮罩
- (void)hiddenVoice {

    [_voiceMask setHidden:YES];
}
- (void)showVoice {
    
    [_voiceMask setHidden:NO];
}


- (void)setupNav {
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnDidClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    [self.searchBar becomeFirstResponder];
}

#pragma mark ----  取消搜索
- (void)rightBtnDidClick :(UIBarButtonItem *)item {
    // 关闭录音
    
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - 监听
//- (void)setResultArray:(NSArray *)resultArray {
//    //  设置数据
//    _resultArray = resultArray;
//    //  更改状态
////    self.result = resultArray.count;
//    //  刷新表格
//    [self.tableView reloadData];
//    //  停掉菊花
//    //    [self hideHud];
//}

#pragma mark -- 搜索代理
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if ([searchText isEqualToString:@""]) {
        return;
    }
}
#pragma mark -- 点击搜索----进入物品排序列表
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 用户是否登录
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    if (kStringIsEmpty(sid)) { // 未登录保存搜索记录
        [JXJudgeStrObjc addSearchrecords:searchBar.text];
    }
    // 搜索到物品进入下一级页面  搜索不到弹窗提示
    [self searchResultskeywords:searchBar.text];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.searchrecordsArray.count;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //  没点搜索，展示默认推荐界面
    if (indexPath.section == 0) //  热门搜索
    {
        UITableViewCell *cell = [self creatKeywordCubCellWithArray:self.hotKeywordsArray toArray :self.hotKeywordsBtnArray inTableView :tableView heightCallBack:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        //  历史搜索
        JXHisRecordTableViewCell *cell = [JXHisRecordTableViewCell cellWithTable];
        if (!kArrayIsEmpty(self.searchrecordsArray)) {
            [cell setY_title:self.searchrecordsArray[indexPath.row]];
        }
        // 有结果，展示结果
        return cell;
        
    }else {
        JXDeletehisTableViewCell *cell = [JXDeletehisTableViewCell cellWithTable];
        
        cell.deletehis = ^{
            BOOL online = [JXUserDefaultsObjc onlineStatus];
            if (!online) { // 用户未登录的清除本地缓存
                [JXUserDefaultsObjc deletesearchdic];
            }else { // 服务端清除
                [JXNetworkRequest asyncDeleteSearchRecordsis_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
                    [self showHint:messagedic[@"msg"]];
                } statisticsFail:^(NSDictionary *messagedic) {
                    [self showHint:messagedic[@"msg"]];
                } fail:^(NSError *error) {
                    
                }];
            }
            [self.searchrecordsArray removeAllObjects];
            [self.tableView reloadData];
        };
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self searchResultskeywords:self.searchrecordsArray[indexPath.row]];
    }
}


// 进入搜索结果界面
- (void)searchResultskeywords:(NSString *)keywords {
    self.dateArray = @[].mutableCopy;
    [JXNetworkRequest asyncSearchGoodkeywords:keywords pagNumber:1 ordernum:1 orderprice:1 is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dateArray addObject:model];
        }
        [self.searchBar resignFirstResponder];
        JXSearchGoodViewController *searchgoods = [[JXSearchGoodViewController alloc] init];
        searchgoods.dateArray = self.dateArray;
        searchgoods.searchStr = keywords;
        searchgoods.retweetType = 2;
        [self.navigationController pushViewController:searchgoods animated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self.searchBar resignFirstResponder];
        [self showHint:@"搜索不到您要的商品"];
    } fail:^(NSError *error) {
        
    }];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  默认展现
    __block CGFloat cellHeight = 0;
    if (indexPath.section == 0)     //  热门搜索
    {
        UITableViewCell *cell = [self creatKeywordCubCellWithArray:[NSArray arrayWithArray:self.hotKeywordsArray] toArray:self.hotKeywordsBtnArray inTableView:tableView heightCallBack:^(CGFloat height) {
            cellHeight = height;
        }];
        cell.hidden = YES;
        return cellHeight + 20;
    }else {
        return TableViewControllerCell_Height;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *header = [[UIView alloc] init]; //根据type 创建 @"热门话题" 或 @"热门目的地";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, NPWidth, 16)];
        [label setText:@"热搜"];
        [label setFont:[UIFont systemFontOfSize:16]];
        [header addSubview:label];
        [header setBackgroundColor:[UIColor whiteColor]];
        return header;
    }
    if (section == 1) {
        
        UIView *header = [[UIView alloc] init]; //根据tyoe 创建 @"添加过的话题" 或 @"历史搜索";
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
        [lineView setBackgroundColor:kUIColorFromRGB(0xf0f2f5)];
        [header addSubview:lineView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 27, NPWidth, 16)];
        [label setText:@"历史记录"];
        [label setFont:[UIFont systemFontOfSize:16]];
        [header setBackgroundColor:[UIColor whiteColor]];
        [header addSubview:label];
        return header;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 50;
    }else if (section == 1){
        return 60;
    }
    return 0;
}

#pragma mark - Inner
- (UITableViewCell *)creatKeywordCubCellWithArray :(NSArray *)keywordArray toArray :(NSMutableArray *)mutableArray inTableView :(UITableView *)tableView heightCallBack :(AZXHeightCallBack)callBack
{
    
    NSMutableArray *nameArray = @[].mutableCopy;
    for (JXHomepagModel *model in keywordArray) {
        [nameArray addObject:model.name];
    }
    
    [mutableArray removeAllObjects];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"keywordCubCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"keywordCubCell"];
    }
    //  创建子View
    UIView *cub = [[UIView alloc] init];
    cub.frame = CGRectMake(0, 0, tableView.bounds.size.width, 250);
    //  关键词组流水布局
    for (int i = 0; i < nameArray.count; i++) {
        //  设置参数
        CGFloat kKeywordMargin = 10;      // 关键词Btn间距
        CGFloat kBtnLeftMarginToCub = 15; //  按钮距屏幕左边距
        CGFloat kBtnRightMarginToCub = 15; // 按钮距屏幕右边距
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:nameArray[i] attributes:@{NSForegroundColorAttributeName : [UIColor redColor] , NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [btn setAttributedTitle:attributeString forState:UIControlStateNormal];
        
        if (mutableArray == self.hotKeywordsBtnArray)
        {
            [btn addTarget:self action:@selector(hotArrayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        //  设置btn宽度和高度
        [btn sizeToFit];
        btn.width += 20;
        btn.height = 27;
        
        //  边框
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        
        btn.backgroundColor = [UIColor whiteColor];
        
        //    流水排布
        if (btn.width > cub.width - 2 * kKeywordMargin)  // 设置Btn最大宽度
        {
            btn.width = cub.width - 2 * kKeywordMargin;
        }
        //  计算Btn的frame
        UIButton *lastBtn = mutableArray.lastObject;
        if (lastBtn == nil)     //  第一个Btn位置
        {
            btn.left = kBtnLeftMarginToCub;
            btn.top = 0;
        }
        else
        {
            CGFloat widthPart = CGRectGetMaxX(lastBtn.frame) + kKeywordMargin;
            btn.left = cub.width - widthPart - kBtnRightMarginToCub > btn.width ? widthPart : kBtnLeftMarginToCub;
            btn.top = cub.width - widthPart - kBtnRightMarginToCub > btn.width ? lastBtn.frame.origin.y : CGRectGetMaxY(lastBtn.frame) + kKeywordMargin;
        }
        //  添加Btn
        [mutableArray addObject:btn];
        [cub addSubview:btn];
    }
    
    UIButton *btn = mutableArray.lastObject;
    cub.height = CGRectGetMaxY(btn.frame);
    if (callBack) {
        callBack(cub.height);
    }
    //  添加到cell
    [cell addSubview:cub];
    cell.bounds = cub.frame;
    return cell;
}
#pragma mark --- 点击热搜按钮
- (void)hotArrayBtnClick :(UIButton *)btn { // btn.tag ,btn.titleLabel.text
    //  返回索引号
    NSMutableArray *nameArray = @[].mutableCopy;
    for (JXHomepagModel *model in self.hotKeywordsArray) {
        [nameArray addObject:model.name];
    }
    NSString *searchid = nameArray[btn.tag];
    [self searchResultskeywords:searchid];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}


/**
 *  键盘添加完成按钮
 */
- (void)sethideKeyBoardAccessoryView{
    
    UIView *accessoryView = [[UIView alloc]init];
    accessoryView.frame = CGRectMake(0, 0, NPWidth, 45);
    accessoryView.backgroundColor = kUIColorFromRGB(0xf1f1f1);
    
    JXRecordingView *record = [[JXRecordingView alloc] initWithFrame:accessoryView.frame];
    record.Recordblock = ^(NSInteger type) {
        if (type == 0) {
            KDLOG(@"-------00000------");
            [self videoStrat];
            [self showVoice];
            [self.recordButton setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
        }else if (type == 1) {
             KDLOG(@"-------11111111------");
            
            [self.recordButton setBackgroundColor:kUIColorFromRGB(0xffffff)];
        }else {
            [self hiddenVoice];
            [self videoclose];
             KDLOG(@"-------222222------");
            
            [self.recordButton setBackgroundColor:kUIColorFromRGB(0xffffff)];
        }
    };
    [accessoryView addSubview:record];
    self.searchBar.inputAccessoryView = accessoryView;
}

// 关闭语音
- (void)videoclose{
    
    if(self.isStreamRec && !self.isBeginOfSpeech){
        NSLog(@"%s,停止录音",__func__);
        [_pcmRecorder stop];
        //        [_popUpView showText: @"停止录音"];
    }
    
    [_iFlySpeechRecognizer stopListening];
}

// 开启语音
- (void)videoStrat{
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        
        self.isCanceled = NO;
        self.isStreamRec = NO;
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            // 禁止按钮
            
        }else{
            [self showHint:@"启动识别服务失败，请稍后重试"]; //可能是上次请求未结束，暂不支持多路并发
            
        }
    }else {
        
        if(_iflyRecognizerView == nil)
        {
            [self initRecognizer ];
        }
        
       
        
        //设置音频来源为麦克风
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        BOOL ret = [_iflyRecognizerView start];
        if (ret) {
             // 禁止按钮
        }
    }
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech
{
    NSLog(@"onBeginOfSpeech");
    
    if (self.isStreamRec == NO)
    {
        self.isBeginOfSpeech = YES;
        KDLOG(@"正在录音");
//        [_popUpView showText: @"正在录音"];
    }
}

/**
 停止录音回调
 ****/
- (void) onEndOfSpeech
{
    NSLog(@"onEndOfSpeech");
    
    [_pcmRecorder stop];
//    [_popUpView showText: @"停止录音"];
}


/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO ) {
        
        //        if (self.isStreamRec) {
        //            //当音频流识别服务和录音器已打开但未写入音频数据时stop，只会调用onError不会调用onEndOfSpeech，导致录音器未关闭
        //            [_pcmRecorder stop];
        //            self.isStreamRec = NO;
        //            NSLog(@"error录音停止");
        //        }
        
        NSString *text ;
        
        if (self.isCanceled) {
            text = @"识别取消";
            
        } else if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                text = @"无识别结果";
            }else {
                text = @"识别成功";
                //清空识别结果
                _result = nil;
            }
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
        
//        [_popUpView showText: text];
        KDLOG(@"%@",text);
    }else {
//        [_popUpView showText:@"识别结束"];
        NSLog(@"errorCode:%d",[error errorCode]);
    }
//
//    [_startRecBtn setEnabled:YES];
//    [_audioStreamBtn setEnabled:YES];
//    [_upWordListBtn setEnabled:YES];
//    [_upContactBtn setEnabled:YES];
    
}

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    _searchBar.text = [NSString stringWithFormat:@"%@%@", _searchBar.text,resultFromJson];
    KDLOG(@"%@",resultFromJson);
//    _result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
//
//    _textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
    }
//    NSLog(@"_result=%@",_result);
//    NSLog(@"resultFromJson=%@",resultFromJson);
//    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textView.text);
}



/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
//    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,result];
    KDLOG(@"%@",[NSString stringWithFormat:@"%@",result]);
}



/**
 听写取消回调
 ****/
- (void) onCancel
{
    NSLog(@"识别取消");
}

-(void) showPopup
{
//    [_popUpView showText: @"正在上传..."];
}

#pragma mark - IFlyPcmRecorderDelegate

- (void) onIFlyRecorderBuffer: (const void *)buffer bufferSize:(int)size
{
    NSData *audioBuffer = [NSData dataWithBytes:buffer length:size];
    
    int ret = [self.iFlySpeechRecognizer writeAudio:audioBuffer];
    if (!ret)
    {
        [self.iFlySpeechRecognizer stopListening];
        
//        [_startRecBtn setEnabled:YES];
//        [_audioStreamBtn setEnabled:YES];
//        [_upWordListBtn setEnabled:YES];
//        [_upContactBtn setEnabled:YES];
        
    }
}

- (void) onIFlyRecorderError:(IFlyPcmRecorder*)recoder theError:(int) error
{
    
}

//音量值范围:0-30
- (void) onIFlyRecorderVolumeChanged:(int) power
{
    //    NSLog(@"%s,power=%d",__func__,power);
    
    if (self.isCanceled) {
//        [_popUpView removeFromSuperview];
        return;
    }
    
    NSString * vol = [NSString stringWithFormat:@"音量：%d",power];
    KDLOG(@"duoshao%@",vol);
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}
- (UISearchBar *)searchBar
{
    if (!_searchBar) { // 70 90
       _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-90, 30)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.delegate = self;
        _searchBar.placeholder = self.placeHolder;
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    //设置输入框边框的颜色
//                                        textField.layer.borderColor = [UIColor blackColor].CGColor;
//                                        textField.layer.borderWidth = 1;
                    
                    //设置输入字体颜色
                    //                    textField.textColor = [UIColor lightGrayColor];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:self.placeHolder
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
//                    imageView.backgroundColor = [UIColor clearColor];
//                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
//                    textField.leftView = imageView;
                }
            }
        }
        [_searchBar becomeFirstResponder];
        _searchBar.tintColor = [UIColor blackColor];
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"bg_sl"] forState:(UIControlStateNormal)];
    }
    return _searchBar;
}


- (NSString *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = @"请输入商品名称";
    }
    return _placeHolder;
}

- (NSMutableArray *)hotKeywordsBtnArray
{
    if (!_hotKeywordsBtnArray) {
        _hotKeywordsBtnArray = @[].mutableCopy;
    }
    return _hotKeywordsBtnArray;
}
- (NSMutableArray *)historyKeywordsBtnArray
{
    if (!_historyKeywordsBtnArray) {
        _historyKeywordsBtnArray = @[].mutableCopy;
    }
    return _historyKeywordsBtnArray;
}


@end
