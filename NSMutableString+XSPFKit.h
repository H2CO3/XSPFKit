/*
  NSMutableString+XSPFKit.h
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import <Foundation/Foundation.h>


@interface NSMutableString (XSPFKit)
- (void) appendPathComponent:(NSString *)path;
- (void) deleteLastPathComponent;
- (void) appendTag:(NSString *)tag contents:(NSString *)contents attributes:(NSDictionary *)attributes indent:(int)indent;
- (void) appendOpeningTag:(NSString *)tag attributes:(NSDictionary *)attributes indent:(int)indent;
- (void) appendClosingTag:(NSString*)tag indent:(int)indent;
@end

