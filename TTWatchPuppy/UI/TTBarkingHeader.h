//
//  TTBarkingHeader.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/10.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#ifndef TTBarkingHeader_h
#define TTBarkingHeader_h

typedef NS_ENUM(NSInteger, TTBarkingViewStyle) {
    TTBarkingViewStyleToast,
    TTBarkingViewStyleAlert
};

#define TTScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define TTScreenHeight ([UIScreen mainScreen].bounds.size.height)

#endif /* TTBarkingHeader_h */
