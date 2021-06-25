//
//  SIOVoiceFilter.h
//  SIOWaveView
//
//  Created by peter Ro on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIOVoiceFilter : NSObject
@property(nonatomic,strong)NSData *data;

-(NSArray *)filteredSamplesForSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
