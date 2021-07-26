//
//  SIOVoiceProvider.h
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^SIOVoiceDataBlock)(NSData *__nullable data);
@interface SIOVoiceProvider : NSObject

/// 从asset中读取音频文件
/// @param asset 音频对象
/// @param block 回调
+(void)loadAudioSamplesFormAsset:(AVAsset *)asset completionBlock:(SIOVoiceDataBlock)block;
@end

NS_ASSUME_NONNULL_END
