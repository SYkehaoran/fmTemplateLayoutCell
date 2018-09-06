//
//  fmFeedTableViewCell.m
//  fmTemplateLayoutCell
//
//  Created by 柯浩然 on 9/3/18.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import "fmFeedTableViewCell.h"
#import "fmFeedEntity.h"
#import "ImageCollectionViewCell.h"
#import "UIView+fm_aligmentRectInsets.h"
@interface fmFeedTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionview;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@property(nonatomic, strong) NSArray *imageArray;

@end

@implementation fmFeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupImageCollectionView];
   
    [self.titleLabel setFm_aligmentRectInsets:^UIEdgeInsets(UIEdgeInsets originInsets) {
        return UIEdgeInsetsMake(0, 0, -10, 0);
    }];

    [self.timelabel setFm_aligmentRectInsets:^UIEdgeInsets(UIEdgeInsets originInsets) {
        return UIEdgeInsetsMake(-16, 0, 0, 0);
    }];
}

- (void)setupImageCollectionView {
    
    self.imageCollectionview.delegate = self;
    self.imageCollectionview.dataSource = self;
    [self.imageCollectionview registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class])];
}

- (void)setEntity:(fmFeedEntity *)entity {
    _entity = entity;
    
    self.titleLabel.text = entity.title;
    self.subTitleLabel.text= entity.content;
    self.imageArray = entity.imageArray;
    self.timelabel.text = entity.time;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}

@end
