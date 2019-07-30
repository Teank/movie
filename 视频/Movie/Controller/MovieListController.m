//
//  MovieListController.m
//  视频
//
//  Created by Teank on 2019/7/29.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "MovieListController.h"
#import <MJRefresh.h>
#import "MovieItemCell.h"
#import "SDWebImage.h"
#import <AFNetworking.h>
#import "TFHppleElement.h"
#import "TFHpple.h"
#import "XPathQuery.h"
#import "MovieModel.h"
#import <MBProgressHUD.h>
#import "MoviePlayController.h"
#define weakSelf __weak typeof(self) weakSelf = self;
static const NSString * host = @"http://www.k2938.com/";

@interface MovieListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray <NSString *>*images;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) MBProgressHUD *mbp;
@property (nonatomic, assign) NSInteger page;
@end

@implementation MovieListController
{
     UICollectionView *collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.images = [@[@"http://tva4.sinaimg.cn/mw690/005BjCpAly1g48h0ebot9j30u015zdmo.jpg",
                    @"http://tva4.sinaimg.cn/mw690/005BjCpAgy1fciqni7ttrj305k08cab4.jpg",
                    @"http://tva4.sinaimg.cn/mw690/005BjCpAly1g5d20yn5mbj30le0u0q7h.jpg",
                    @"http://tva4.sinaimg.cn/mw690/005BjCpAgw1eygna0mw1dj30bx0goadx.jpg",
                    @"http://tva4.sinaimg.cn/mw690/005BjCpAgw1f3u5n8vx0ij30b90gomzz.jpg"] mutableCopy];
    self.movies  = [NSMutableArray array];
    self.mbp = [[MBProgressHUD alloc]init];
    [self requestDataIsLoadMore:NO];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake(200, 360);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.headerReferenceSize = CGSizeMake(0, 1);
    layout.footerReferenceSize = CGSizeMake(0, 1);
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"id"];
    [collectionView registerNib:[UINib nibWithNibName:@"MovieItemCell" bundle:nil] forCellWithReuseIdentifier:@"MovieItemCell"];
    //__weak typeof(self) weakSelf = self;

    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self requestDataIsLoadMore:NO];
    }];
    collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self requestDataIsLoadMore:YES];
    }];
}


#pragma mark - 网络请求
- (void) requestDataIsLoadMore:(BOOL)isLoadMore {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    if (!isLoadMore) {
        self.page = 1;
    }
    [manager GET:[self getUrl] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self->collectionView.mj_header endRefreshing];
        [self->collectionView.mj_footer endRefreshing];
        NSString *theXML = [[NSString alloc] initWithBytes: [responseObject bytes] length:[responseObject length] encoding:NSUTF8StringEncoding];
        if (!isLoadMore) {
            [self.movies removeAllObjects];
        }
        [self processHTML:theXML isLoadMore:NO];
        NSLog(@"over");
        [self->collectionView reloadData];
        self.page++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self->collectionView.mj_header endRefreshing];
        [self->collectionView.mj_footer endRefreshing];
     }];
}

- (NSString*)getUrl {
    return [NSString stringWithFormat:@"%@type/%ld/%ld.html",host,(long)self.type,(long)self.page];
}

-(void)processHTML:(NSString*)htmlString isLoadMore:(BOOL)isLoadMore{
    NSData *data =[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *hpple  = [[TFHpple alloc] initWithHTMLData:data];
//    NSArray *array =[hpple searchWithXPathQuery:@"//body"];
    NSArray *array =[hpple searchWithXPathQuery :@"//div"];
    TFHppleElement *HppleElement1 =  [array objectAtIndex:10];
    TFHppleElement *HppleElement2 =  [HppleElement1.children objectAtIndex:5];
    TFHppleElement *HppleElement3 =  [HppleElement2.children objectAtIndex:1];
//    TFHppleElement *HppleElement4 =  [HppleElement3.children objectAtIndex:1];
    for (TFHppleElement *HppleElement in HppleElement3.children) {
        
        if ([HppleElement.attributes[@"class"] isEqualToString:@"p1 m1"]) {  //找出  ul标签下  节点属性type   属性值为 disc 的数组
             MovieModel *imovie =[[MovieModel alloc] init];
            NSArray *array2  = [HppleElement searchWithXPathQuery:@"//div"];
            TFHppleElement *movieItemElement = [array2 firstObject];
//            movieItemElement = HppleElement;
            TFHppleElement *div_a_element = [[movieItemElement searchWithXPathQuery:@"//a"] firstObject];   //url
            TFHppleElement *div_div_element = [[movieItemElement searchWithXPathQuery:@"//div"] firstObject];
            TFHppleElement *div_div_div_element = [[div_div_element searchWithXPathQuery:@"//div"] lastObject];
//            TFHppleElement *li_a_img_element = [[li_a_element searchWithXPathQuery:@"//img"] firstObject]; //img
//            TFHppleElement *li_a_p_element = [[li_a_element searchWithXPathQuery:@"//p"] firstObject];   //time
//            TFHppleElement *li_ul_li_element = [[li_ul_element searchWithXPathQuery:@"//li"] firstObject];   //title
//            TFHppleElement *title_element = [[li_ul_li_element searchWithXPathQuery:@"//a"] firstObject];   //title
            NSString *playurl =   nil;//[div_a_element objectForKey:@"href"];
            TFHppleElement *tagelement = [[ [[HppleElement searchWithXPathQuery:@"//a"] firstObject] searchWithXPathQuery:@"//i"] firstObject];
            NSString *showurl =   [[[HppleElement searchWithXPathQuery:@"//a"] firstObject] objectForKey:@"href"];
            NSString *img = [[[HppleElement searchWithXPathQuery:@"//img"] firstObject] objectForKey:@"src"];//[div_a_element objectForKey:@"src"];
            NSString *title = [[[HppleElement searchWithXPathQuery:@"//a"] firstObject] objectForKey:@"title"];//[div_a_element objectForKey:@"title"];
            NSString *subtitle = div_div_div_element.text;
           
            imovie.title = title;
            imovie.subTitle = subtitle;
            imovie.playUrl = playurl;
            imovie.coverUrlStr = img;
            imovie.showUrl = showurl;
            imovie.tagStr = tagelement.text;
            [self.movies addObject:imovie];
        }
    }
    
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
- (void)viewDidLayoutSubviews {
    
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieItemCell" forIndexPath:indexPath];
    MovieModel *item = [self.movies objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:item.coverUrlStr] placeholderImage:[UIImage imageNamed: @"image_placeholder"]];
    cell.titleLabel.text = item.title;// @"漂泊者OAD ドリフターズ OAD";
    cell.subTitleLabel.text  = item.subTitle;//@"更新时间：2019-07-27";
    cell.tagLabel.text = item.tagStr;//@"高清中字";
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MoviePlayController *playVC = [[MoviePlayController alloc]init];
    playVC.movieModel = self.movies[indexPath.row];
    [self presentViewController:playVC animated:YES completion:nil];// pushViewController:playVC animated:YES];
}

@end
