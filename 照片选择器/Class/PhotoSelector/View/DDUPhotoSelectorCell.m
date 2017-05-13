//
//  DDUPhotoSelectorCell.m
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "DDUPhotoSelectorCell.h"

@interface DDUPhotoSelectorCell ()

@property (nonatomic, strong) UIButton *addButton;


@property (nonatomic, strong) UIButton *deleteButton;

@end


@implementation DDUPhotoSelectorCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI{

    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.deleteButton];
    
    //约束
    //去除autoResizing
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束  VFL
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[ab]-0-|" options:0 metrics:nil views:@{@"ab":self.addButton}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[ab]-0-|" options:0 metrics:nil views:@{@"ab":self.addButton}]];
    
    //删除按钮
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[db]-0-|" options:0 metrics:nil views:@{@"db":self.deleteButton}]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[db]" options:0 metrics:nil views:@{@"db":self.deleteButton}]];

}

#pragma mark -  设置加号按钮
-(void)setupAddButton{
    [self.addButton setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
    self.deleteButton.hidden = YES;
}


#pragma mark - 加号按钮被点击了
-(void)addButtonDidClick{
  
    if ([self.delegate respondsToSelector:@selector(photoSelectorCellDidClickAddButton:)]) {
        [self.delegate photoSelectorCellDidClickAddButton:self];
    }

}

#pragma mark - 删除按钮被点击
-(void)didClickDeleteButton{
    if ([self.delegate respondsToSelector:@selector(photoSelectorCellDidClickDeleteButton:)]) {
        [self.delegate photoSelectorCellDidClickDeleteButton:self];
    }
}


#pragma mark - setter
-(void)setImage:(UIImage *)image{

    _image = image;
    [self.addButton setImage:image forState:UIControlStateNormal];
     self.deleteButton.hidden = NO;
}


#pragma mark -  懒加载
-(UIButton *)addButton{
    if (_addButton == nil) {
        _addButton =[[UIButton alloc]init];
        [_addButton setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        //设置按钮图片的填充模式
        _addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //添加点击事件
        [_addButton addTarget:self action:@selector(addButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton =[[UIButton alloc]init];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        //添加点击事件didClickDeleteButton
        [_deleteButton addTarget:self action:@selector(didClickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteButton;
}




@end
