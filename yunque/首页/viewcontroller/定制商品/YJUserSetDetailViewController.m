//
//  YJUserSetDetailViewController.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetDetailViewController.h"
#import "CustomChooseView.h"


@interface YJUserSetDetailViewController (){
    UIScrollView *scrollView;
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UILabel *adressLabel;
    
    CustomChooseView *choseTitleView;
    CustomChooseView *choseTypeView;
    CustomChooseView *choseSpaceView;
    CustomChooseView *choseBeiZhuView;
    
    CustomChooseView *choseMenSaneView;
    CustomChooseView *choseMenDongView;
    CustomChooseView *choseQiangView;
    CustomChooseView *choseBanView;
    
    CustomChooseView *choseMenStyleView;
    CustomChooseView *choseMenDoorStyleView;
    CustomChooseView *choseMenCaiLiaoStyleView;
    CustomChooseView *choseMenOpemnStyleView;
    
     CustomChooseView *choseGuJiaStyleView;
     CustomChooseView *choseTianChongWuStyleView;
     CustomChooseView *choseMenPeiStyleView;
     CustomChooseView *choseMenSuoStyleView;
     CustomChooseView *choseLaShouStyleView;
     CustomChooseView *chosBaShouStyleView;
    
    CustomChooseView *choseMenTouHeightDongView;
    CustomChooseView *choseMenTouWeightView;
    CustomChooseView *choseMenTouClorView;
    
    CustomChooseView *choseMenZhuHeightView;
    CustomChooseView *choseMenZhuWeightView;
    CustomChooseView *choseMenZhuClorView;
    
    
    UIImageView *doorStyleImageView;
    UIImageView *menStyleImageView;
    UIImageView *peiStyleImageView;
    NSDictionary *dic;

}

@end

@implementation YJUserSetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品详情";
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    dic = [[NSDictionary alloc]init];
     [self reoadDate];
   
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/diy/info?diyModelId=%@",BASE_URL,_diyModelId];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->dic = [result objectForKey:@"data"];
         [self SetUI];
        [self setBottomUI];
    }];
    
}
- (void)setBottomUI{
    UILabel *chicun = [[UILabel alloc]init];
    chicun.text = @"尺寸信息";
    chicun.font = [UIFont systemFontOfSize:12];
    chicun.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:chicun];
    [chicun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->choseBeiZhuView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    choseMenSaneView = [[CustomChooseView alloc]init];
    choseMenSaneView.NameLabel.text = @"门扇尺寸";
    NSString *menSanWeightStr = [dic objectForKey:@"doorLeafHeight"];
    NSString *menSanHeightStr = [dic objectForKey:@"doorLeafWidth"];
    NSString *menSanstr1;
    NSString *menSanStr2;
    if ([menSanWeightStr integerValue]) {
        menSanstr1 = menSanWeightStr;
    }else{
        menSanstr1 = @"暂未填写";
    }
    if ([menSanHeightStr integerValue]) {
        menSanStr2 = menSanHeightStr;
    }else{
        menSanStr2 = @"暂未填写";
    }
    choseMenSaneView.ChooseLabel.text =  [NSString stringWithFormat:@"长:%@毫米;宽:%@毫米",menSanstr1,menSanStr2];
    
    [scrollView addSubview:choseMenSaneView];
    [choseMenSaneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseBeiZhuView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenDongView = [[CustomChooseView alloc]init];
    choseMenDongView.NameLabel.text = @"门洞尺寸";
    
    NSString *menaDonWeightStr = [dic objectForKey:@"doorOpeningHeight"];
    NSString *menDonHeightStr = [dic objectForKey:@"doorOpeningWidth"];
    NSString *menDonStr1;
    NSString *menDonStr2;
    if ([menSanWeightStr integerValue]) {
        menDonStr1 = menaDonWeightStr;
    }else{
        menDonStr1 = @"暂未填写";
    }
    if ([menDonHeightStr integerValue]) {
        menDonStr2 = menDonHeightStr;
    }else{
        menDonStr2 = @"暂未填写";
    }
    choseMenDongView.ChooseLabel.text =  [NSString stringWithFormat:@"长:%@毫米;宽:%@毫米",menDonStr1,menDonStr2];
    [scrollView addSubview:choseMenDongView];
    [choseMenDongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenSaneView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseQiangView = [[CustomChooseView alloc]init];
    choseQiangView.NameLabel.text = @"墙体厚度";
    NSString *qiangstr =[dic objectForKey:@"wallThickness"];
    if ([qiangstr integerValue]) {
        choseQiangView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",qiangstr];
    }else{
        choseQiangView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseQiangView];
    [choseQiangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenDongView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseBanView = [[CustomChooseView alloc]init];
    choseBanView.NameLabel.text = @"门板厚度";
    NSString *Banstr =[dic objectForKey:@"doorPanelThickness"];
    if ([Banstr integerValue]) {
        choseBanView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",Banstr];
    }else{
        choseBanView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseBanView];
    [choseBanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseQiangView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UILabel *yangshi = [[UILabel alloc]init];
    yangshi.text = @"样式信息";
    yangshi.font = [UIFont systemFontOfSize:12];
    yangshi.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:yangshi];
    [yangshi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->choseBanView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    choseMenStyleView = [[CustomChooseView alloc]init];
    choseMenStyleView.NameLabel.text = @"门型";
    NSString *choseMenStyleViewstr =[dic objectForKey:@"doorType"];
    if (choseMenStyleViewstr.length ) {
        choseMenStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenStyleViewstr];
    }else{
        choseMenStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenStyleView];
    [choseMenStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseBanView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenDoorStyleView = [[CustomChooseView alloc]init];
    choseMenDoorStyleView.NameLabel.text = @"颜色";
    NSString *choseMenColorstr =[dic objectForKey:@"doorColor"];
    if (choseMenColorstr.length ) {
        choseMenDoorStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenColorstr];
    }else{
        choseMenDoorStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenDoorStyleView];
    [choseMenDoorStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenCaiLiaoStyleView = [[CustomChooseView alloc]init];
    choseMenCaiLiaoStyleView.NameLabel.text = @"材料";
    NSString *choseMenCaiLiaoStyleViewstr =[dic objectForKey:@"material"];
    if (choseMenCaiLiaoStyleViewstr.length ) {
        choseMenCaiLiaoStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenCaiLiaoStyleViewstr];
    }else{
        choseMenCaiLiaoStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenCaiLiaoStyleView];
    [choseMenCaiLiaoStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenDoorStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenOpemnStyleView = [[CustomChooseView alloc]init];
    choseMenOpemnStyleView.NameLabel.text = @"开门方式";
    NSString *choseMenOpemnStyleViewstr =[dic objectForKey:@"openingDirection"];
    if (choseMenOpemnStyleViewstr.length ) {
        choseMenOpemnStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenOpemnStyleViewstr];
    }else{
        choseMenOpemnStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenOpemnStyleView];
    [choseMenOpemnStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenCaiLiaoStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    doorStyleImageView = [[UIImageView alloc]init];
    [doorStyleImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"style"]]];
    [scrollView addSubview:doorStyleImageView];
    
    [doorStyleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenOpemnStyleView.mas_bottom).offset(60);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);
    }];
    
    UILabel *tianchongshi = [[UILabel alloc]init];
    tianchongshi.text = @"门配配置选择";
    tianchongshi.font = [UIFont systemFontOfSize:12];
    tianchongshi.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:tianchongshi];
    [tianchongshi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->doorStyleImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    choseGuJiaStyleView = [[CustomChooseView alloc]init];
    choseGuJiaStyleView.NameLabel.text = @"骨架";
    NSString *choseGuJiaStyleViewstr =[dic objectForKey:@"skeleton"];
    if (choseGuJiaStyleViewstr.length ) {
        choseGuJiaStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseGuJiaStyleViewstr];
    }else{
        choseGuJiaStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseGuJiaStyleView];
    [choseGuJiaStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->doorStyleImageView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseTianChongWuStyleView  = [[CustomChooseView alloc]init];
    choseTianChongWuStyleView.NameLabel.text = @"填充物";
    NSString *choseTianChongWuStyleViewstr =[dic objectForKey:@"filler"];
    if (choseTianChongWuStyleViewstr.length ) {
        choseTianChongWuStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseTianChongWuStyleViewstr];
    }else{
        choseTianChongWuStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseTianChongWuStyleView];
    [choseTianChongWuStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseGuJiaStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenPeiStyleView = [[CustomChooseView alloc]init];
    choseMenPeiStyleView.NameLabel.text = @"门配";
    NSString *str1;NSString *str2;NSString *str3;NSString *str4;NSString *str5;
    switch ([[dic objectForKey:@"transom"]integerValue]) {
        case 0:
            str1 = @"封闭";
            break;
        case 1:
            str1 = @"开放";
            break;
        default:
            break;
    }
    switch ([[dic objectForKey:@"doorbell"]integerValue]) {
        case 0:
            str2 = @"无";
            break;
        case 1:
            str2 = @"有";
            break;
        default:
            break;
    }
    switch ([[dic objectForKey:@"cateye"]integerValue]) {
        case 0:
            str3 = @"无";
            break;
        case 1:
            str3 = @"有";
            break;
        default:
            break;
    }
    switch ([[dic objectForKey:@"downshift"]integerValue]) {
        case 0:
            str4 = @"无";
            break;
        case 1:
            str4 = @"有";
            break;
        default:
            break;
            break;
    }
    switch ([[dic objectForKey:@"hinge"]integerValue]) {
        case 0:
            str5 = @"明";
            break;
        case 1:
            str5 = @"暗";
            break;
        default:
            break;
    }
    choseMenPeiStyleView.ChooseLabel.text = [NSString stringWithFormat:@"气窗:%@;门铃:%@;猫眼:%@;下档%@;铰链:%@",str1,str2,str3,str4,str5];
    choseMenPeiStyleView.ChooseLabel.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:choseMenPeiStyleView];
    [choseMenPeiStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseTianChongWuStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenSuoStyleView     = [[CustomChooseView alloc]init];
    choseMenSuoStyleView.NameLabel.text = @"门锁";
    NSString *choseMenSuoStyleViewstr =[dic objectForKey:@"doorLock"];
    if (choseMenSuoStyleViewstr.length ) {
        choseMenSuoStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenSuoStyleViewstr];
    }else{
        choseMenSuoStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenSuoStyleView];
    [choseMenSuoStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenPeiStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseLaShouStyleView     = [[CustomChooseView alloc]init];
    choseLaShouStyleView.NameLabel.text = @"拉手";
    NSString *choseLaShouStyleViewstr =[dic objectForKey:@"handle"];
    if (choseLaShouStyleViewstr.length ) {
        choseLaShouStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseLaShouStyleViewstr];
    }else{
        choseLaShouStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseLaShouStyleView];
    [choseLaShouStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenSuoStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    chosBaShouStyleView     = [[CustomChooseView alloc]init];
    chosBaShouStyleView.NameLabel.text = @"把手";
    NSString *chosBaShouStyleViewstr =[dic objectForKey:@"knob"];
    if (chosBaShouStyleViewstr.length ) {
        chosBaShouStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",chosBaShouStyleViewstr];
    }else{
        chosBaShouStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:chosBaShouStyleView];
    [chosBaShouStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseLaShouStyleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UILabel *MenToutitle = [[UILabel alloc]init];
    MenToutitle.text = @"门头信息";
    MenToutitle.font = [UIFont systemFontOfSize:12];
    MenToutitle.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:MenToutitle];
    [MenToutitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->chosBaShouStyleView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    choseMenTouHeightDongView = [[CustomChooseView alloc]init];
    choseMenTouHeightDongView.NameLabel.text = @"门头高";
    NSString *choseMenTouHeightDongViewstr =[dic objectForKey:@"doorHeadHigh"];
    if ([choseMenTouHeightDongViewstr integerValue]) {
        choseMenTouHeightDongView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",choseMenTouHeightDongViewstr];
    }else{
        choseMenTouHeightDongView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenTouHeightDongView];
    [choseMenTouHeightDongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->chosBaShouStyleView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenTouWeightView = [[CustomChooseView alloc]init];
    choseMenTouWeightView.NameLabel.text = @"门头宽";
    NSString *choseMenTouWeightViewstr =[dic objectForKey:@"doorHeadWidth"];
    if ([choseMenTouWeightViewstr integerValue]) {
        choseMenTouWeightView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",choseMenTouWeightViewstr];
    }else{
        choseMenTouWeightView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenTouWeightView];
    [choseMenTouWeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenTouHeightDongView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenTouClorView = [[CustomChooseView alloc]init];
    choseMenTouClorView.NameLabel.text = @"颜色";
    NSString *choseMenTouClorViewstr =[dic objectForKey:@"knob"];
    if (choseMenTouClorViewstr.length ) {
        chosBaShouStyleView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenTouClorViewstr];
    }else{
        chosBaShouStyleView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenTouClorView];
    [choseMenTouClorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenTouWeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    menStyleImageView = [[UIImageView alloc]init];
    [menStyleImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"doorHeadStyle"]]];
    [scrollView addSubview:menStyleImageView];
    
    [menStyleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenTouClorView.mas_bottom).offset(30);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);
    }];
    UILabel *MenZhutitle = [[UILabel alloc]init];
    MenZhutitle.text = @"门柱信息";
    MenZhutitle.font = [UIFont systemFontOfSize:12];
    MenZhutitle.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:MenZhutitle];
    [MenZhutitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->menStyleImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    choseMenZhuHeightView = [[CustomChooseView alloc]init];
    
    choseMenZhuHeightView.NameLabel.text = @"门柱高";
    NSString *choseMenZhuHeightViewstr =[dic objectForKey:@"doorColumnHigh"];
    if ([choseMenZhuHeightViewstr integerValue]) {
        choseMenZhuHeightView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",choseMenZhuHeightViewstr];
    }else{
        choseMenZhuHeightView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenZhuHeightView];
    [choseMenZhuHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->menStyleImageView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenZhuWeightView = [[CustomChooseView alloc]init];
    choseMenZhuWeightView.NameLabel.text = @"门柱宽";
    NSString *choseMenZhuWeightViewstr =[dic objectForKey:@"doorColumnWidth"];
    if ([choseMenZhuWeightViewstr integerValue]) {
        choseMenZhuWeightView.ChooseLabel.text =[NSString stringWithFormat:@"%@毫米",choseMenZhuWeightViewstr];
    }else{
        choseMenZhuWeightView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenZhuWeightView];
    [choseMenZhuWeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenZhuHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenZhuClorView  = [[CustomChooseView alloc]init];
    choseMenZhuClorView.NameLabel.text = @"颜色";
    NSString *choseMenZhuClorViewtr =[dic objectForKey:@"doorColumnColor"];
    if (choseMenZhuClorViewtr.length ) {
        choseMenZhuClorView.ChooseLabel.text =[NSString stringWithFormat:@"%@",choseMenZhuClorViewtr];
    }else{
        choseMenZhuClorView.ChooseLabel.text =@"暂未填写";
    }
    [scrollView addSubview:choseMenZhuClorView];
    [choseMenZhuClorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenZhuWeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    peiStyleImageView = [[UIImageView alloc]init];
    [peiStyleImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"doorColumnStyle"]]];
    [scrollView addSubview:peiStyleImageView];
    
    [peiStyleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenZhuClorView.mas_bottom).offset(30);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);
    }];
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)SetUI{
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*4);
    [self.view addSubview:scrollView];
    UIView *topBackView = [[UIView alloc]init];
    topBackView.backgroundColor = [UIColor whiteColor];
    topBackView.layer.masksToBounds = YES;
    topBackView.layer.cornerRadius = 5;
    [scrollView addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->scrollView.mas_left).offset(20);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(120);
    }];
    nameLabel = [[UILabel alloc]init];
    nameLabel.text = [dic objectForKey:@"nickName"];
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [topBackView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBackView.mas_left).offset(20);
        make.top.mas_equalTo(topBackView.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = [dic objectForKey:@"phoneNumber"];
    phoneLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [topBackView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBackView.mas_left).offset(20);
        make.top.mas_equalTo(self->nameLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    adressLabel = [[UILabel alloc]init];
    adressLabel.text = [dic objectForKey:@"address"];
    adressLabel.numberOfLines = 0;
    adressLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    adressLabel.font = [UIFont systemFontOfSize:12];
    [topBackView addSubview:adressLabel];
    [adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBackView.mas_left).offset(20);
        make.top.mas_equalTo(self->phoneLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"基本信息";
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [scrollView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(topBackView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    
    
    choseTitleView = [[CustomChooseView alloc]init];
    choseTitleView.NameLabel.text = @"标题";
    choseTitleView.ChooseLabel.text =[dic objectForKey:@"name"];
    [scrollView addSubview:choseTitleView];
    [choseTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(topBackView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseTypeView = [[CustomChooseView alloc]init];
    choseTypeView.NameLabel.text = @"分类";
    choseTypeView.ChooseLabel.text = [dic objectForKey:@"categoryName"];
    [scrollView addSubview:choseTypeView];
    [choseTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseTitleView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseSpaceView = [[CustomChooseView alloc]init];
    choseSpaceView.NameLabel.text = @"空间";
    choseSpaceView.ChooseLabel.text = [dic objectForKey:@"spaceName"];
    [scrollView addSubview:choseSpaceView];
    [choseSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseTypeView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseBeiZhuView = [[CustomChooseView alloc]init];
    choseBeiZhuView.NameLabel.text = @"备注";
    NSString *str =[dic objectForKey:@"remark"];
    if (str.length ) {
        choseBeiZhuView.ChooseLabel.text = [dic objectForKey:@"remark"];
    }else{
        choseBeiZhuView.ChooseLabel.text =@"暂未填写";
    }
  
    [scrollView addSubview:choseBeiZhuView];
    [choseBeiZhuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseSpaceView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
   
  
}
- (void)LoginNextBtn{
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
