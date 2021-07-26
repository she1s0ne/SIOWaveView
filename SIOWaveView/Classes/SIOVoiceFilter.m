//
//  SIOVoiceFilter.m
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import "SIOVoiceFilter.h"

@implementation SIOVoiceFilter
-(NSArray *)filteredSamplesForSize:(CGSize)size{
    NSMutableArray *filteredSamples = [[NSMutableArray alloc]init];
    //    每个样本为16字节,得到样本数量
    NSInteger samplesCount = self.data.length / sizeof(SInt16);
    NSInteger binSize = samplesCount / size.width;
    SInt16 *bytes = (SInt16 *)self.data.bytes;
    //    [self.data getBytes:&bytes length:self.data.length];
    SInt16 maxSample = 0;
    //sint16两个字节的空间
    //以binSize为一个样本。每个样本中取一个最大数。也就是在固定范围取一个最大的数据保存，达到缩减目的
    for (NSUInteger i= 0; i < samplesCount; i += binSize) {
        //在sampleCount（所有数据）个数据中抽样，抽样方法为在binSize个数据为一个样本，在样本中选取一个数据
        SInt16 sampleBin [binSize];
        for (NSUInteger j = 0; j < binSize; j++) {//先将每次抽样样本的binSize个数据遍历出来
            ///越界保护
            if (i + j > samplesCount) {
                sampleBin[j] = (uint16_t)0;
            }else {
                sampleBin[j] = CFSwapInt16LittleToHost(bytes[i + j]);
            }
        }
        //选取样本数据中最大的一个数据
        SInt16 value = [self maxValueInArray:sampleBin ofSize:binSize];
//        if (value <= 0) {
//            value = 10;
//        }

        //保存数据
        [filteredSamples addObject:@(value)];
        //将所有数据中的最大数据保存，作为一个参考。可以根据情况对所有数据进行“缩放”
        if (value > maxSample) {
            maxSample = value;
        }
    }
    CGFloat scaleFactor = (size.height / 1.0) / maxSample;
    for (NSUInteger i = 0; i < filteredSamples.count; i++) {

        filteredSamples[i] = @([filteredSamples[i] integerValue] * scaleFactor);
        if ([filteredSamples[i] integerValue] * scaleFactor<= 0.0) {
            filteredSamples[i] = @(10);
        }
    }
    return filteredSamples;
}

//比较大小的方法，返回最大值
- (SInt16)maxValueInArray:(SInt16[])values ofSize:(NSUInteger)size {SInt16 maxvalue = 0;
    for (int i = 0; i < size; i++) {

        if (abs(values[i] > maxvalue)) {

            maxvalue = abs(values[i]);
        }
    }
    return maxvalue;
}
@end
