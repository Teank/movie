//
//  MoviePlayController.m
//  视频
//
//  Created by Teank on 2019/7/30.
//  Copyright © 2019 tiank. All rights reserved.
//

#import "MoviePlayController.h"
#import "WMPlayer.h"
#import "Masonry.h"
#import <MJRefresh.h>
#import "MovieItemCell.h"
#import "SDWebImage.h"
#import <AFNetworking.h>
#import "TFHppleElement.h"
#import "TFHpple.h"
#import "XPathQuery.h"
#import "MovieModel.h"
#import <MBProgressHUD.h>
static const NSString * host = @"http://www.k2938.com/";

@interface MoviePlayController ()

@end

@implementation MoviePlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = @"csdfsdfsdf";///self.videoModel.title;
    playerModel.videoURL = [NSURL URLWithString: self.movieModel.playUrl] ;//[NSURL fileURLWithPath:@"/Users/teank/Desktop/Video/test.MOV"];
    WMPlayer * wmPlayer = [WMPlayer playerWithModel:playerModel];
    [self.view addSubview:wmPlayer];
//    wmPlayer.frame = self.playerContentView.frame;// CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 9 / 16);
    
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(self.view);
                make.top.mas_equalTo(self.view.mas_top);
                make.height.mas_equalTo(self.view.frame.size.height/2);
    }];
    [wmPlayer play];
    
    self.descLabel.text = self.movieModel.descStr;
    [self.view bringSubviewToFront:self.backBtn];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 网络请求
- (void) requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    if (!isLoadMore) {
        self.page = 1;
    }
    [manager GET:[self getUrl] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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


- (IBAction)backAct:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
