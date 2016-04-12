//
//  DJPhotoBrowser.h
//  photobrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DJButton, DJPhotoBrowser;

@protocol DJPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(DJPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(DJPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface DJPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView; // 装载你的ImageViews的View,如果是collectionView 直接 sourceImagesContainerView = collectionView
@property (nonatomic, assign) NSInteger currentImageIndex;//点击的图片index
@property (nonatomic, assign) NSInteger imageCount;//图片的数量
@property (nonatomic, copy) void (^dismissCallBack)();
@property (nonatomic, assign) id<DJPhotoBrowserDelegate> delegate;

- (void)show;

@end
