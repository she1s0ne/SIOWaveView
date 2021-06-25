//
//  SIOVoiceProvider.h
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^SIOVoiceDataBlock)(NSData *data);
@interface SIOVoiceProvider : NSObject
+(void)loadAudioSamplesFormAsset:(AVAsset *)asset completionBlock:(SIOVoiceDataBlock)block;
@end

NS_ASSUME_NONNULL_END
