//
//  LawJCImageSelect.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/27.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawJCImageSelect.h"

@implementation LawJCImageSelect

+(LawJCImageSelect *)defaultSelectImage{
  static LawJCImageSelect * selectImage  = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectImage  = [[LawJCImageSelect alloc]init];
    });
    return selectImage;
}

-(void)showInViewController:(UIViewController *)showController{

    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self; //设置代理
    imagePickerController.allowsEditing = YES;
//    判断是否支持相机 不支持相机直接进入图片库中选择
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {


    UIAlertController * alControll = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * camera =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera; //图片来源
        [showController presentViewController:imagePickerController animated:YES completion:nil];


    }];
    UIAlertAction * Photo =[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片来源
        [showController presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction * cancel  =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alControll addAction:camera];
    [alControll addAction:Photo];
    [alControll addAction:cancel];

    [showController presentViewController:alControll animated:YES completion:nil];
    }else{
         imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [showController presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}
#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
//    _headerV.image = image;  //给UIimageView赋值已经选择的相片
    if ([self.delegate respondsToSelector:@selector(seleWithImage:)]) {
        [self.delegate seleWithImage:image];
    }
    
    //上传图片到服务器--在这里进行图片上传的网络请求，这里不再介绍
}
//当用户取消选择的时候，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate  respondsToSelector:@selector(cancelSelecImage)]) {
            [self.delegate cancelSelecImage];
        }
        
    }];
}
@end
