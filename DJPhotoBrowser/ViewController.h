//
//  ViewController.h
//  DJPhotoBrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ImageModel : NSObject
@property (nonatomic,copy) NSString *image;//大图URL
@property (nonatomic,copy) NSString *images;//小图URL
@end

@interface ViewController : UIViewController


@end

