//
//  DDUPhotoSelectorCell.h
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDUPhotoSelectorCell;

@protocol DDUPhotoSelectorCellDelegate <NSObject>

-(void)photoSelectorCellDidClickAddButton:(DDUPhotoSelectorCell *)cell;

-(void)photoSelectorCellDidClickDeleteButton:(DDUPhotoSelectorCell *)cell;

@end

@interface DDUPhotoSelectorCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;//图片属性暴露给外面

@property (nonatomic, weak) id<DDUPhotoSelectorCellDelegate> delegate;

-(void)setupAddButton;

@end
