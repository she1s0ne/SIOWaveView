//
//  SIOViewController.m
//  SIOWaveView
//
//  Created by lp on 06/25/2021.
//  Copyright (c) 2021 lp. All rights reserved.
//

#import "SIOViewController.h"
#import "SIOWaveView.h"
@interface SIOViewController ()

@end

@implementation SIOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    SIOWaveView *waveView = [[SIOWaveView alloc]initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 50)];
    [self.view addSubview:waveView];

    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@".mp3"]];
    AVURLAsset *musicAsset = [[AVURLAsset alloc]initWithURL:url options:nil];
    waveView.asset = musicAsset;
    waveView.lineWidth = 2;
    waveView.lineDistance = 4;
    waveView.lineColor = UIColor.purpleColor;
    [waveView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
