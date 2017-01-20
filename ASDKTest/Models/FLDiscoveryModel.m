//
//  FLDiscoveryModel.m
//  SwiftLive
//
//  Created by Bert on 16/4/22.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import "FLDiscoveryModel.h"

@implementation FLDiscoveryModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        [self setValue:value forKey:@"ID"];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSString *string = [NSString stringWithFormat:@"%@", value];
    [super setValue:string forKey:key];
}

+ (FLDiscoveryModel *)setupModel {
    FLDiscoveryModel *model = [[FLDiscoveryModel alloc]init];
    model.avatar = @"http://cdn.ylive.info/images/201611/103/ab67e7418be9b099e4d683fb5b954c50_750x750.jpg";
    model.bind_type = @"2";
    model.coin = @"6";
    model.country = @"0";
    model.create_time = @"1479853407";
    model.diamond = @"0";
    model.follow_count = @"0";
    model.gcm_token = nil;
    model.ID = @"220";
    model.ios_token = @"79b2386797332bc657a27ba6ba35a9749fd58b227a698e496e54da49e844f796";
    model.is_update_nick = @"0";
    model.live_id = @"-1";
    model.sort_id = @"";
    model.title = @"";
    model.type = @"3";
    model.update_time = @"1483298737";
    model.follower_count = @"1135";
    model.gender = @"2";
    model.gift = @"2";
    model.nick = @"Alexis Ramos";
    model.signature = @"Spread love";
    model.uid = @"57295";
    model.avatar_small = @"http://cdn.ylive.info/images/201611/103/903fe7a9f8c0852fe4d90e13278b0b26_100x100.jpg";
    
    return model;
}

@end
