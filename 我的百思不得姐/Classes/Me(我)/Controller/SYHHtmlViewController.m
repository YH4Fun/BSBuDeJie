//
//  SYHHtmlViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/21.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHHtmlViewController.h"
#import "SYHSquareItem.h"

#import <WebKit/WebKit.h>

@interface SYHHtmlViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ForwardItem;

@property (nonatomic ,weak)UIProgressView *progressView;
@property (nonatomic ,weak)WKWebView *webView;

@end

@implementation SYHHtmlViewController
- (IBAction)clickBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)clickForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)clickRefresh:(id)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadHtml];
    
    [self setupProgressView];
    
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupProgressView
{
    CGFloat y = self.navigationController ? 64 : 0;
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, y, SYHScreenW, 1)];
    self.progressView = progressView;
    [self.contentView addSubview:progressView];
    progressView.progressTintColor = [UIColor orangeColor];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    self.ForwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.progressView.progress == 1;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"URL"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)loadHtml
{
    WKWebView *webView = [[WKWebView alloc] init];
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    _webView = webView;
    [self.contentView addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_item.url]];
    [webView loadRequest:request];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.contentView.bounds;
}










@end
