//
//  CollectionViewCell.h
//  DJPhotoBrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageModel;
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) ImageModel *model;
@end
