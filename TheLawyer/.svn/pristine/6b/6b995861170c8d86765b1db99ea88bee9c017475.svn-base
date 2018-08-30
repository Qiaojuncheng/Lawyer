//
//  MainDetailCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/30.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MainDetailCell.h"

@implementation MainDetailCell
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.frame = CGRectMake(15, 10, SCREENWIDTH-30, 20);
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.textColor = RGBMCOLOR(153);
        _subTitleLabel.hidden = YES;
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.frame = CGRectMake(15, 20, SCREENWIDTH-30, 70);
        
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _subTitleLabel;
}

#pragma mark -- 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        
        
        
        
//        self.titleLabel.sd_layout
//        .topSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView, 15)
//        .heightIs(20)
//        .widthIs(SCREENWIDTH-20);
        
//        self.subTitleLabel.frame = CGRectMake(15, 30, SCREENWIDTH-30, 70);
        
//        self.subTitleLabel.sd_layout
//        .topSpaceToView(self.contentView, 40)
//        .leftSpaceToView(self.contentView, 15)
//        .heightIs(70)
//        .widthIs(SCREENWIDTH-30);
        
    }
    return self;
}


- (void)setTempModel:(MainDetailModel *)tempModel {
    if (_tempModel != tempModel) {
        _tempModel = tempModel;
    }
//    
//    self.titleLabel.text = tempModel.XTitle;
//    self.subTitleLabel.text = tempModel.username;
//
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
//    CGSize size = [tempModel.XTitle boundingRectWithSize:CGSizeMake(0, 18) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
