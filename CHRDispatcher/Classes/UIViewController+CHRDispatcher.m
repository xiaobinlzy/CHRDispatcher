//
//  UIViewController+CHRDispatcher.m
//  CHRDispatcher
//
//  Created by DLL on 2017/9/26.
//

#import "UIViewController+CHRDispatcher.h"
#import <objc/runtime.h>

@implementation UIViewController (CHRDispatcher)

- (void)dispatcher_setValuesForKeys:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:NSDictionary.class]) {
        for (NSString *key in dictionary) {
            id value = dictionary[key];
            objc_property_t property = class_getProperty(self.class, [key cStringUsingEncoding:NSUTF8StringEncoding]);
            if (property) {
                if ([value isKindOfClass:NSString.class]) {
                    char *type = property_copyAttributeValue(property, "T");
                    switch (type[0]) {
                        case 'f':
                        case 'd':
                        case 'c':
                        case 's':
                        case 'i':
                        case 'l':
                        case 'q':
                        case 'I':
                        case 'S':
                        case 'L':
                        case 'Q':
                        {
                            NSScanner *scanner = [[NSScanner alloc] initWithString:value];
                            double number = 0;
                            [scanner scanDouble:&number];
                            value = [NSNumber numberWithDouble:number];
                        }
                            break;
                        case 'B':
                        {
                            NSString *lowerValue = [value lowercaseString];
                            BOOL boolean = [lowerValue isEqualToString:@"true"] || [lowerValue isEqualToString:@"yes"] || [lowerValue isEqualToString:@"1"];
                            value = [NSNumber numberWithBool:boolean];
                        }
                            break;
                    }
                    if (type) {
                        free(type);
                    }
                }
                [self setValue:value forKey:key];
            }
        }
    }
}

@end
