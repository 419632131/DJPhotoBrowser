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
    
    CollectionViewCell *cell = (CollectionViewCell *)[self.collect cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect rect = [self.collect convertRect:cell.frame toView:self.view];
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
    if (CGRectContainsPoint(self.view.bounds, rect.origin) == NO || (rect.origin.x == 5 && rect.origin.y == 5)) {
        
        UICollectionViewScrollPosition scrollPosition;
        if (rect.origin.y < - 150) { // 这个值应该以每个item的高＋2*边距
            scrollPosition = UICollectionViewScrollPositionBottom;
        }else{
            scrollPosition = UICollectionViewScrollPositionTop;
        }
        [self.collect scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:scrollPosition animated:YES];
    }
    return cell.image.image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
