//
//  NSObject+TTAutoLayout.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/12/8.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TTAutoLayout)

+ (void)hookAutoLayoutException;

+ (void)registerUnsatisfiableAutoLayoutBlock:(dispatch_block_t)block;


@end
