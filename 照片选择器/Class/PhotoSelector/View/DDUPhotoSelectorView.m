//
//  DDUPhotoSelectorView.m
//  照片选择器
//
//  Created by Danny on 2017/5/9.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "DDUPhotoSelectorView.h"
#import "DDUPhotoSelectorCell.h"
#import "UIImage+ASyncDraw.h"
static NSString * const kReuseIdentifier = @"DDUPhotoSelectorCell";
@interface DDUPhotoSelectorView ()<UICollectionViewDataSource,UICollectionViewDelegate,DDUPhotoSelectorCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation DDUPhotoSelectorView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI{
    self.maxCount = 6;
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
//    layout
    layout.itemSize = CGSizeMake(80,80);
//    layout.minimumInteritemSpacing = 15;
    //初始化collectionView
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) collectionViewLayout:layout ];

    //注册cell
    [_collectionView registerClass:[DDUPhotoSelectorCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    _collectionView.backgroundColor =[UIColor whiteColor];
//    CGFloat margin = [UIScreen mainScreen].bounds.size.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //数据源 代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self addSubview:_collectionView];
    //约束

}



#pragma mark -  数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //当图片还没有达到最大张时 显示图片和一个加号按钮
    //当图片达到最大张数时显示的是最大张数
    return self.photos.count < self.maxCount ? (self.photos.count + 1) : self.photos.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DDUPhotoSelectorCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor =[UIColor brownColor];
    
    //将图片给cell
    cell.delegate= self;
    
    if (indexPath.item < self.photos.count) {
        cell.image = self.photos[indexPath.item];
    }else{
        [cell setupAddButton];
    }
    return cell;
}


#pragma mark - DDUPhotoSelectorCellDelegate
-(void)photoSelectorCellDidClickDeleteButton:(DDUPhotoSelectorCell *)cell{
    NSIndexPath *indexPath =[self.collectionView indexPathForCell:cell];
    [self.photos removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
}

-(void)photoSelectorCellDidClickAddButton:(DDUPhotoSelectorCell *)cell{
    UIImagePickerController *pickerVC =[[UIImagePickerController alloc]init];
    
    pickerVC.delegate = self;
    [self.targetVC presentViewController:pickerVC animated:YES completion:nil];
    
}


#pragma mark - UIImagePickerControllerDelegate 和 UINavigationControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    //等比例缩小到300
    CGFloat newWidth = 300;
    CGFloat newHeight = newWidth * image.size.height/image.size.width;
    
    NSLog(@"newWidth:%f---newHeight:%f",newWidth,newHeight);
    //将图片缩小
    [image ddu_AsyncDrawImage:CGSizeMake(newHeight, newHeight) bgColor:[UIColor whiteColor] isCorner:NO drawFinish:^(UIImage *image) {
        //绘制好的图片
        [self.photos addObject:image];
        //刷新数据
        [self.collectionView reloadData];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
}


#pragma mark -  getter
-(NSMutableArray *)photos{
    if (_photos == nil) {
        _photos =[NSMutableArray array];
    }
    return _photos;
}




@end
