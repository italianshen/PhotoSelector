//
//  ViewController.m
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "ViewController.h"
#import "DDUPhotoSelectorController.h"

#import "DDUPhotoSelectorView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DDUPhotoSelectorView *photoSelectorView =[[DDUPhotoSelectorView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    photoSelectorView.backgroundColor =[UIColor cyanColor];
    
    __weak typeof(self)weakSelf = self;
    
    photoSelectorView.targetVC = weakSelf;
    
    [self.view addSubview:photoSelectorView];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    DDUPhotoSelectorController *photoSelector =[[DDUPhotoSelectorController alloc]init];
    
    [self.navigationController pushViewController:photoSelector animated:YES];

}


@end
