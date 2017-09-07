//
//  NewsDetailViewController.m
//  YYText
//
//  Created by 1 on 2017/9/7.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
@interface NewsDetailViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)NSDictionary *htmlDic;
@property (nonatomic, strong) WKWebView *wkWebView;
@property(nonatomic,strong)UIProgressView*progressView;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
   
    [self initProgerss];
    [self requestData];
    [self initWKwebView];
    // Do any additional setup after loading the view.
}
-(void)initWKwebView{
 
    
    WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
    
    //设置configur对象的preferences属性的信息
    WKPreferences *preferences = [[WKPreferences alloc] init];
    configur.preferences = preferences;
    
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preferences.javaScriptEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"openBigPicture"];
    [userContentController addScriptMessageHandler:self name:@"openVideoPlayer"];
    configur.userContentController = userContentController;
    WKWebView *webview=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configur];
    webview.scrollView.scrollIndicatorInsets = webview.scrollView.contentInset;
    
    webview.UIDelegate = self;
    webview.backgroundColor = [UIColor redColor];
    webview.navigationDelegate = self;
    [webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:webview];
//     [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    self.wkWebView= webview;

}
-(void)initProgerss{


    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1)];
    progressView.progress = 0.0;
    progressView.progressTintColor = [UIColor yellowColor];
    
    [self.view addSubview:progressView];
    self.progressView = progressView;

}
-(void)requestData{

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =[session dataTaskWithURL:[NSURL URLWithString:@"http://c.m.163.com/nc/article/C1EIHLG905298O5P/full.html"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        self.htmlDic=dict[@"C1EIHLG905298O5P"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.navigationItem.title = self.htmlDic[@"title"];
            
        }];
        
        NSLog(@"---%@",dict);
        [self loadHtmlStr];
        
    }];
    
    [task resume];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

     self.progressView.progress = self.wkWebView.estimatedProgress;
    NSLog(@"-estimatedProgress--%f",self.wkWebView.estimatedProgress);

}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    
    completionHandler();
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    
    
}
 - (void)loadHtmlStr {

     NSString *body = self.htmlDic[@"body"];
     
     NSString *title = self.htmlDic[@"title"];
     
     
     NSDictionary *videoDict = self.htmlDic[@"video"][0];
     NSString *videoUrl = videoDict[@"mp4_url"];
     NSString *alt = videoDict[@"alt"];
     NSString *videoRef = videoDict[@"ref"];
     
     
     NSString *videoHtml = [NSString stringWithFormat:@"<div>\
                            <video class=\"video0\" src=\"%@\" autoPlay=\"true\">\
                            </video>\
                            <div class=\"videoDescribe\">%@</div>\
                            </div>\
                            ",videoUrl,alt];
     if (videoRef) {
         
         body = [body stringByReplacingOccurrencesOfString:videoRef withString:videoHtml];
         
     }
     NSString *sourceName = [NSString string];
     if(self.htmlDic[@"articleTags"]){
         sourceName = self.htmlDic[@"articleTags"];
     }else {
         sourceName = self.htmlDic[@"source"];
     }
     NSString *sourceTime = self.htmlDic[@"ptime"];
     NSArray *imagArray = self.htmlDic[@"img"];
     
     for (NSDictionary *imageDict in imagArray) {
     
         //图片在body中的占位标识，比如"<!--IMG#3-->"
         NSString *imageRef = imageDict[@"ref"];
         //图片的url
         NSString *imageSrc = imageDict[@"src"];
         //图片下面的文字说明
         NSString *imageAlt = imageDict[@"alt"];
         
         NSString *imageHtml  = [NSString string];
         
         //把对应的图片url转换成html里面显示图片的代码
         if (imageAlt) {
             
             imageHtml = [NSString stringWithFormat:@"<div><img width=\"100%%\" src=\"%@\"><div class=\"picDescribe\">%@</div></div>",imageSrc,imageAlt];
         }else{
             imageHtml = [NSString stringWithFormat:@"<div><img width=\"100%%\" src=\"%@\"></div>",imageSrc];
         }
         
         body = [body stringByReplacingOccurrencesOfString:imageRef withString:imageHtml];
     
     }
     
     NSURL *cssPath = [[NSBundle mainBundle] URLForResource:@"newDetail" withExtension:@"css"];
     NSURL *jsPath = [[NSBundle mainBundle] URLForResource:@"newDetail" withExtension:@"js"];
     
     NSString *html = [NSString stringWithFormat:@"\
                       <html lang=\"en\">\
                       <head>\
                       <meta charset=\"UTF-8\">\
                       <link href=\"%@\" rel=\"stylesheet\">\
                       <link rel=\"stylesheet\" href=\"http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css\">\
                       <script src=\"%@\"type=\"text/javascript\"></script>\
                       </head>\
                       <body id=\"mainBody\">\
                       <header>\
                       <div id=\"father\">\
                       <div id=\"mainTitle\">%@</div>\
                       <div id=\"sourceTitle\"><span class=\"source\">%@</span><span class=\"time\">%@</span></div>\
                       <video id=\"video1\" autoPlay=\"true\" src=\"http://flv2.bn.netease.com/videolib3/1609/24/VFTsu6784/HD/VFTsu6784-mobile.mp4\" controls=\"controls\">\
                       </video>\
                       <div class=\"button01 glyphicon glyphicon-play\"></div>\
                       <p class=\"lindan\">超级丹吊炸天</p>\
                       <div>%@</div>\
                       </div>\
                       </header>\
                       </body>\
                       </html>"\
                       ,cssPath,jsPath,title,sourceName,sourceTime,body];
     
     [self.wkWebView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];

}
- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 因此这里要记得移除handlers
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"openBigPicture"];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"openVideoPlayer"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
