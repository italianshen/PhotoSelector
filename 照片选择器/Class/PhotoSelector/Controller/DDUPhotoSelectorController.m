//
//  DDUPhotoSelectorController.m
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "DDUPhotoSelectorController.h"
#import "DDUPhotoSelectorCell.h"
#import "UIImage+ASyncDraw.h"
@interface DDUPhotoSelectorController ()<DDUPhotoSelectorCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;



@end

@implementation DDUPhotoSelectorController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{

    return [super initWithCollectionViewLayout:self.layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxCount = 8;
    //布局参数设置
    self.layout.itemSize = CGSizeMake(80, 80);
    //注册cell
    [self.collectionView registerClass:[DDUPhotoSelectorCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor =[UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - 数据源
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//
//  
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //当图片还没有达到最大张时 显示图片和一个加号按钮
    //当图片达到最大张数时显示的是最大张数
    return self.photos.count < self.maxCount ? (self.photos.count + 1) : self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DDUPhotoSelectorCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
-(void)photoSelectorCellDidClickAddButton:(DDUPhotoSelectorCell *)cell{
    UIImagePickerController *pickerVC =[[UIImagePickerController alloc]init];
    
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];

}


-(void)photoSelectorCellDidClickDeleteButton:(DDUPhotoSelectorCell *)cell{
    NSIndexPath *indexPath =[self.collectionView indexPathForCell:cell];
    [self.photos removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
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



#pragma mark -  懒加载
-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout =[[UICollectionViewFlowLayout alloc]init];
    }
    return _layout;

}


-(NSMutableArray *)photos{

    if (_photos == nil) {
        _photos =[NSMutableArray array];
    }
    return _photos;
}
@end
