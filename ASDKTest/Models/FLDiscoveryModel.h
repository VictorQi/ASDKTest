//
//  FLDiscoveryModel.h
//  SwiftLive
//
//  Created by Bert on 16/4/22.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLDiscoveryModel : NSObject

@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *avatar_big;
@property (nonatomic,strong) NSString *bind_type;
@property (nonatomic,strong) NSString *coin;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *diamond;
@property (nonatomic,strong) NSString *follow_count;//关注的人的个数
@property (nonatomic,strong) NSString *gcm_token;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *ios_token;
@property (nonatomic,strong) NSString *is_update_nick;
@property (nonatomic,strong) NSString *live_id;
@property (nonatomic,strong) NSString *sort_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *update_time;
@property (nonatomic,strong) NSString *follower_count;//粉丝个数
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *gift;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *avatar_small;

+ (FLDiscoveryModel *)setupModel;

@end
