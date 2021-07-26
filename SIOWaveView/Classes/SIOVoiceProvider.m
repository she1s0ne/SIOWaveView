//
//  SIOVoiceProvider.m
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import "SIOVoiceProvider.h"

@implementation SIOVoiceProvider

+(void)loadAudioSamplesFormAsset:(AVAsset *)asset completionBlock:(SIOVoiceDataBlock)block{
    NSString *tracks = @"tracks";
    [asset loadValuesAsynchronouslyForKeys:@[tracks] completionHandler:^{
        NSInteger status = [asset statusOfValueForKey:tracks error:nil];
        NSData *sampleData;
        if (status == AVKeyValueStatusLoaded) {
            sampleData = [self readAudioSamplesFromAVsset:asset];
            if (sampleData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(sampleData);
                });
            }else{
                //读取音频数据失败
                block(nil);
            }
        }
    }];
}

+(NSData *)readAudioSamplesFromAVsset:(AVAsset *)asset{
    NSError *error;
    AVAssetReader *assetReader = [[AVAssetReader alloc]initWithAsset:asset error:&error];
    if (error) {
        return nil;
    }
    AVAssetTrack *track = [[asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    if (!track) {
        return nil;
    }
    //读取配置
    NSDictionary *dic = @{AVFormatIDKey :@(kAudioFormatLinearPCM),
                          AVLinearPCMIsBigEndianKey:@NO,
                          AVLinearPCMIsFloatKey:@NO,
                          AVLinearPCMBitDepthKey :@(16)
                          };
    //读取输出，在相应的轨道和输出对应格式的数据
    AVAssetReaderTrackOutput *output = [[AVAssetReaderTrackOutput alloc]initWithTrack:track outputSettings:dic];
    [assetReader addOutput:output];
    [assetReader startReading];

    NSMutableData *sampleData = [[NSMutableData alloc]init];
    while (assetReader.status == AVAssetReaderStatusReading) {
        //读取到数据
        CMSampleBufferRef sampleBuffer = [output copyNextSampleBuffer];
        if (sampleBuffer) {
            //取出数据
            CMBlockBufferRef blockBUfferRef = CMSampleBufferGetDataBuffer(sampleBuffer);
            size_t length = CMBlockBufferGetDataLength(blockBUfferRef);
            //返回一个大小，size_t针对不同的品台有不同的实现，扩展性更好
            SInt16 sampleBytes[length];
            //将数据放入数组
            CMBlockBufferCopyDataBytes(blockBUfferRef, 0, length, sampleBytes);
            //将数据附加到data中
            [sampleData appendBytes:sampleBytes length:length];
            //销毁
            CMSampleBufferInvalidate(sampleBuffer);
            //释放
            CFRelease(sampleBuffer);
        }
    }
    if (assetReader.status == AVAssetReaderStatusCompleted) {
        return sampleData;
    }
    return nil;
}
@end
