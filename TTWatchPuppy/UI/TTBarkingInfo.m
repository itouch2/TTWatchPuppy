//
//  TTBarkingInfo.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingInfo.h"

@interface TTSnapshot ()

@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSArray<NSString *> *callStackSymbols;

@end


@implementation TTSnapshot

- (instancetype)init {
    self = [super init];
    if (self) {
        _timestamp = [NSDate date];
        _callStackSymbols = [NSThread callStackSymbols];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _timestamp = [coder decodeObjectForKey:@"timestamp"];
        _callStackSymbols = [coder decodeObjectForKey:@"callStackSymbols"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.timestamp forKey:@"timestamp"];
    [coder encodeObject:self.callStackSymbols forKey:@"callStackSymbols"];
}

@end

@interface TTBarkingInfo ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) TTSnapshot *snapshot;

@end


@implementation TTBarkingInfo


- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description {
    self = [super init];
    if (self) {
        _title = [title copy];
        _desc = [description copy];
        _snapshot = [[TTSnapshot alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _title = [coder decodeObjectForKey:@"title"];
        _desc = [coder decodeObjectForKey:@"desc"];
        _snapshot = [coder decodeObjectForKey:@"snapshot"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.desc forKey:@"desc"];
    [coder encodeObject:self.snapshot forKey:@"snapshot"];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    TTBarkingInfo *info = [TTBarkingInfo allocWithZone:zone];
    info.title = self.title;
    info.desc = self.desc;
    info.snapshot = self.snapshot;
    info.style = self.style;
    return info;
}

@end
