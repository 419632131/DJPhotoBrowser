//
//  DJPhotoBrowserConfig.h
//  DJPhotoBrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//


typedef enum {
    DJWaitingViewModeLoopDiagram, // 环形
    DJWaitingViewModePieDiagram // 饼型
} DJWaitingViewMode;

// 图片保存成功提示文字
#define DJPhotoBrowserSaveImageSuccessText @"保存成功";

// 图片保存失败提示文字
#define DJPhotoBrowserSaveImageFailText @"保存失败";

// browser背景颜色
#define DJPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

// browser中图片间的margin
#define DJPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define DJPhotoBrowserShowImageAnimationDuration 0.4f

// browser中显示图片动画时长
#define DJPhotoBrowserHideImageAnimationDuration 0.4f

// 图片下载进度指示进度显示样式（DJWaitingViewModeLoopDiagram 环形，DJWaitingViewModePieDiagram 饼型）
#define DJWaitingViewProgressMode DJWaitingViewModeLoopDiagram

// 图片下载进度指示器背景色
#define DJWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define DJWaitingViewItemMargin 10


