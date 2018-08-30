//
//  LawJCImageSelect.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/27.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  selectImagedelegate <NSObject>
-(void)seleWithImage:(UIImage *)selectImage;
-(void)cancelSelecImage;
@end
@interface LawJCImageSelect : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (assign,nonatomic) id<selectImagedelegate>  delegate;


+(LawJCImageSelect *)defaultSelectImage;

-(void)showInViewController:(UIViewController *)showController;
@end
