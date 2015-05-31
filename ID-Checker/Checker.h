//
//  Checker.h
//  ID-Checker
//
//  Created by Chen Hsin Hsuan on 2015/5/31.
//  Copyright (c) 2015年 AirconTW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checker : NSObject


+(BOOL) checkTaiwanId:(NSString*)id;
+(BOOL) checkChinaId:(NSString*)id;
+(BOOL) checkKoreaId:(NSString*)id;
+(BOOL) checkHongKongId:(NSString*)id;
@end
