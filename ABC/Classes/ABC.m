//
//  ABC.m
//  ABC
//
//  Created by SRS on 2020/12/23.
//

#import "ABC.h"

@implementation ABC
- (void)test:(NSString *)params {
    NSLog(@"ABC:%@", params);
    [self test1:params];
}

- (void)test1:(NSString *)params {
    NSLog(@"test1 ABC:%@", params);
}

@end
