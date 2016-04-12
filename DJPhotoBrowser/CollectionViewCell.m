//
//  CollectionViewCell.m
//  DJPhotoBrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CollectionViewCell.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
//        self.image.contentMode = UIViewContentModeScaleAspectFill;
        self.image.layer.cornerRadius = _image.frame.size.height/10;
        self.image.layer.masksToBounds = YES;
        [self.contentView addSubview:_image];
    }
    return self;
}
- (void)setModel:(ImageModel *)model
{
    _model = model;
    if (_model.images.length > 0) {
        [_image sd_setImageWithURL:[NSURL URLWithString:_model.images] placeholderImage:[UIImage imageNamed:@"place"]];
    }else{
        [_image sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    }
}
@end
