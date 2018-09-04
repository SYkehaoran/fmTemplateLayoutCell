//
//  fmFeedTableViewCell.m
//  fmTemplateLayoutCell
//
//  Created by 柯浩然 on 9/3/18.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import "fmFeedTableViewCell.h"
#import "fmFeedEntity.h"
#import "UIView+fm_aligmentRectInsets.h"
@interface fmFeedTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@end

@implementation fmFeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel setFm_aligmentRectInsets:^UIEdgeInsets(UIEdgeInsets originInsets) {
        return UIEdgeInsetsMake(0, 0, -10, 0);
    }];
    [self.mainImageView setFm_aligmentRectInsets:^UIEdgeInsets(UIEdgeInsets originInsets) {
        return UIEdgeInsetsMake(-8, 0, 0, 0);
    }];
    [self.timelabel setFm_aligmentRectInsets:^UIEdgeInsets(UIEdgeInsets originInsets) {
        return UIEdgeInsetsMake(-16, 0, 0, 0);
    }];
}

+ (id)loadView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([fmFeedTableViewCell class]) owner:nil options:nil].firstObject;
}

- (void)setEntity:(fmFeedEntity *)entity {
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.subTitleLabel.text= entity.content;
    self.mainImageView.image = [UIImage imageNamed:entity.imageName];
    self.timelabel.text = entity.time;
}

@end
