//
//  SIOWaveView.h
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SIOWaveView : UIView
//指定以下任一一个即可
@property(nonatomic,copy)NSString *path;//文件路径
@property(nonatomic,strong)NSURL *url;//文件url
@property(nonatomic,strong)AVAsset *asset;//媒体文件

@property(nonatomic,assign)CGFloat lineWidth;//线的宽度,默认0
@property(nonatomic,strong)UIColor *lineColor;//线的颜色,默认红色
@property(nonatomic,assign)CGFloat lineDistance;//线之间的间距,默认4
@property (nonatomic) BOOL showLines;
-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
