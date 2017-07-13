//
//  BSTopicViewCell.m
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSTopicViewCell.h"

#import "BSTopicModel.h"
#import "UIImageView+WebCache.h"

@implementation BSTopicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setModel:(BSTopicModel *)model {

    _model = model;
    
    self.nameLabel.text = model.name;
    self.posTime.text = model.passtime;
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    // 类型为段子
    if (model.type == BSTopicTypeWord) {
        
        if (self.content.superview == nil) {

            self.content.text = model.text;
            
            [self.contentView addSubview:self.content];
            
        }else{
            self.content.text = model.text;
            
        }
        
        self.content.frame = CGRectMake(0, kCellTextY, kSCREEN_WIDTH, self.model.textHeight);

        
    }
    
}



- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(0, kCellTextY, kSCREEN_WIDTH, self.model.textHeight)];
        _content.font = [UIFont systemFontOfSize:15];
        _content.layer.masksToBounds = YES;
        _content.numberOfLines = 0;
    }
    
    return _content;
}












- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
