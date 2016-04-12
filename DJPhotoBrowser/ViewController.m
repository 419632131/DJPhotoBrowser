//
//  ViewController.m
//  DJPhotoBrowser
//
//  Created by Jason on 7/4/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "DJPhotoBrowser.h"
#import "CollectionViewCell.h"

@implementation ImageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@interface ViewController () <DJPhotoBrowserDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *models;
@property (nonatomic,strong)UICollectionView *collect;
@end

@implementation ViewController
- (NSMutableArray *)models
{
    return _models?_models:(_models = @[].mutableCopy);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getDateSoure];
    
    [self initUI];
}

- (void)getDateSoure
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSArray *datas = [[NSArray alloc] initWithContentsOfFile:path];
    for (NSDictionary *dic in datas) {
        ImageModel *model = [ImageModel new];
        [model setValuesForKeysWithDictionary:dic];
        [self.models addObject:model];
    }
}

- (void)initUI
{
    CGFloat wight = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat margin = 5;
    UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowlayout.itemSize = CGSizeMake((wight-4*margin)/3 , (wight-4*margin)/3);
    
    flowlayout.minimumInteritemSpacing = margin;
    flowlayout.minimumLineSpacing = margin ;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, wight, height) collectionViewLayout:flowlayout];
    self.collect.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    self.collect.backgroundColor = [UIColor whiteColor];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    [self.view addSubview:self.collect];
    [self.collect registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [_collect dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ImageModel *model = self.models[indexPath.row];
    
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJPhotoBrowser *browser = [[DJPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.sourceImagesContainerView = self.collect;
    browser.imageCount = self.models.count;
    browser.delegate = self;
    [browser show];
}


- (NSURL *)photoBrowser:(DJPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    ImageModel *model = self.models[index];
    NSString *urlStr;
    if (model.image.length > 0) {
        urlStr = model.image;
    }else{
        urlStr = model.images;
    }
    
    return [NSURL URLWithString:urlStr];
}

- (UIImage *)photoBrowser:(DJPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    int newRow = index % 3;
    __weak CollectionViewCell *cell = (CollectionViewCell *)[self.collect cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (newRow == 2) {
        CGRect rect = [self.collect convertRect:cell.frame toView:self.view];
        if (rect.origin.y <= 250) {
            NSInteger row = index - 3;
            if (row>=0) {
                [self.collect scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }
        }
        if (rect.origin.y >= self.view.frame.size.height-250) {
            NSInteger row = index + 1;
            if (row < self.models.count) {
                [self.collect scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            }
        }
    }

    return cell.image.image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
    {
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

@end
