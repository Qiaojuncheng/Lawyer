//
//  XMyAccountCell.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/24.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "XMyAccountCell.h"

@interface XMyAccountCell ()


@end

@implementation XMyAccountCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.textColor = RGBMCOLOR(153);
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _subTitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头"]];
    }
    return _arrowImageView;
}

- (UIImageView *)headView {
    if (!_headView) {
        _headView = [UIImageView new];
                     
        _headView.image = [UIImage imageNamed:@"tuceng"];
                     
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = 22;
                
        _headView.hidden = YES;
    }
    return _headView;
}

#pragma mark -- 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.headView];
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 15)
        .widthIs(SCREENWIDTH / 2.0 - 15 - 30);
        
        self.subTitleLabel.sd_layout
        .topEqualToView(self.titleLabel)
        .leftSpaceToView(self.titleLabel, 10)
        .bottomEqualToView(self.titleLabel)
        .widthIs(SCREENWIDTH / 2.0 - 15);
        
        self.arrowImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(17.5)
        .widthIs(10);
        
        self.headView.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 35)
        .bottomSpaceToView(self.contentView, 15)
        .widthIs(44);
        
    }
    return self;
}


- (void)setTempModel:(XSetVCModel *)tempModel {
    if (_tempModel != tempModel) {
        _tempModel = tempModel;
    }
    
    self.titleLabel.text = tempModel.XTitle;
    self.subTitleLabel.text = tempModel.XSubTitle;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = [tempModel.XTitle boundingRectWithSize:CGSizeMake(0, 18) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
