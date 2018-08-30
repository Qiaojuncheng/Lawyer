//
//  XSetVCCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "XSetVCCell.h"

@interface XSetVCCell ()



@end

@implementation XSetVCCell

- (UILabel *)XTitleLabel {
    if (!_XTitleLabel) {
        _XTitleLabel = [UILabel new];        
        [_XTitleLabel setNormalFont:14];
        _XTitleLabel.textColor = [UIColor colorWithHex:0x333333];
    }
    return _XTitleLabel;
}

- (UILabel *)XSubTitleLabel {
    if (!_XSubTitleLabel) {
        _XSubTitleLabel = [UILabel new];
        _XSubTitleLabel.textAlignment = NSTextAlignmentRight;
        _XSubTitleLabel.textColor = RGBMCOLOR(153);
        [_XSubTitleLabel setNormalFont:14];
    }
    return _XSubTitleLabel;
}

- (UIImageView *)XArrowImageView {
    if (!_XArrowImageView) {
        _XArrowImageView = [UIImageView new];
        [_XArrowImageView setImage:[UIImage imageNamed:@"箭头"]];
    }
    return _XArrowImageView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor= LINECOLOR;
    }
    return _line;
}

// 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 背景色
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.XTitleLabel];
        [self.contentView addSubview:self.XSubTitleLabel];
        [self.contentView addSubview:self.XArrowImageView];
        
        WS(ws);
        [self.XTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView).offset(15);
            make.top.equalTo(ws.contentView).offset(12);
            make.bottom.equalTo(ws.contentView).offset(-12);
            make.width.mas_equalTo(80);
        }];
        
        [self.XArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-15);
            make.centerY.equalTo(ws.contentView);
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
        }];
        
        [self.XSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.XTitleLabel.mas_right);
            make.top.equalTo(ws.contentView).offset(12);
            make.bottom.equalTo(ws.contentView).offset(-12);
            make.right.equalTo(ws.XArrowImageView.mas_right).offset(-15);
        }];

        // 线
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.contentView);
            make.right.equalTo(ws.contentView);
            make.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setTempModel:(XSetVCModel *)tempModel {
    if (_tempModel != tempModel) {
        _tempModel = tempModel;
    }
    
    self.XTitleLabel.text = tempModel.XTitle;
    self.XSubTitleLabel.text = tempModel.XSubTitle;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = [tempModel.XTitle boundingRectWithSize:CGSizeMake(0, 18) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
    
    // 修改约束
    [self.XTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width + 1);
    }];
    
    // cell类型
    if (tempModel.type == 1) {
        // 隐藏箭头
        self.XArrowImageView.hidden = YES;
        // 修改副标题约束
        WS(ws);
        [self.XSubTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView).offset(-15);
        }];
    }
    
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
