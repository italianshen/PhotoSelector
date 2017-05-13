//
//  DDUPhotoSelectorView.h
//  照片选择器
//
//  Created by Danny on 2017/5/9.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDUPhotoSelectorView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSMutableArray *photos;


@property (nonatomic, assign) NSInteger maxCount;

//目标控制器
@property (nonatomic, strong) UIViewController *targetVC;

@end
