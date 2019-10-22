//
//  YJChoseMoneyTypeTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/14.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJChoseMoneyTypeTableViewCell.h"

@implementation YJChoseMoneyTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellValuesInfoWith:(NSDictionary *)title level:(NSInteger)level children:(NSInteger )children  additionButtonHidden:(BOOL)additionButtonHidden{
    [self removeAllSubviews];
    _choseNameLabel = [[UILabel alloc]init];
    _choseNameLabel.text= [title objectForKey:@"categoryName"];
    [self addSubview:_choseNameLabel];
    [_choseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(70+level*10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _choseImageView = [[UIImageView alloc]init];
    _choseImageView.image= [UIImage imageNamed:@"单选未选中"];
    [self addSubview:_choseImageView];
    [_choseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(50+level*10);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.image= [UIImage imageNamed:@"展开"];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
    
    _additionButtonHidden = additionButtonHidden;
//    if (additionButtonHidden) {
//        _choseImageView.image= [UIImage imageNamed:@"单选未选中"];
//    }else{
//        _choseImageView.image= [UIImage imageNamed:@"单选选中"];
//    }
    if (children == 0) {
        //向上的箭头
          _iconImageView.image= [UIImage imageNamed:@"收起"];
    }else{
        //向下的箭头
          _iconImageView.image= [UIImage imageNamed:@"展开"];
    }
}
+ (instancetype)treeViewCellWith:(RATreeView *)treeView  arrayCourse:(NSArray *)arrayCourse{
    
    YJChoseMoneyTypeTableViewCell *cell = [treeView dequeueReusableCellWithIdentifier:@"chodeTableViewCell"];
    
    if (cell == nil) {
        
        cell = [[YJChoseMoneyTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chodeTableViewCell"];
        
    }
    
    ///arrayCourse是我传递的参数模型
    
    ///_arrayCourseModel储存传递模型
    
    //rrayCourseModel = arrayCourse;
    
    return cell;
    
}
#pragma mark - Properties

- (void)setAdditionButtonHidden:(BOOL)additionButtonHidden
{
    [self setAdditionButtonHidden:additionButtonHidden animated:NO];
}

- (void)setAdditionButtonHidden:(BOOL)additionButtonHidden animated:(BOOL)animated
{
    _additionButtonHidden = additionButtonHidden;
    if (additionButtonHidden) {
         _choseImageView.image= [UIImage imageNamed:@"单选未选中"];

    }else{
         _choseImageView.image= [UIImage imageNamed:@"单选选中"];
    }
}


#pragma mark - Actions

- (IBAction)additionButtonTapped:(id)sender
{
    if (self.additionButtonTapAction) {
        self.additionButtonTapAction(sender);
    }
}
@end
