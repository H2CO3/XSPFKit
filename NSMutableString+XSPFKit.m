/*
  NSMutableString+XSPFKit.m
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import "NSMutableString+XSPFKit.h"


@implementation NSMutableString (XSPFKit)

- (void) appendPathComponent:(NSString *)path {
	NSString *tmp = [self stringByAppendingPathComponent:path];
	[self setString:tmp];
}

- (void) deleteLastPathComponent {
	NSString *tmp = [self stringByDeletingLastPathComponent];
	[self setString:tmp];
}

- (void) appendTag:(NSString *)tag contents:(NSString *)contents attributes:(NSDictionary *)attributes indent:(int)indent {
	if (!tag || !contents) {
		return;
	}
	for (int i = 0; i < indent; i++) {
		[self appendString:@"\t"];
	}
	NSMutableString *attr = [[NSMutableString alloc] init];
	int count = [attributes count];
	for (int i = 0; i < count; i++) {
		NSString *key = [[attributes allKeys] objectAtIndex:i];
		NSString *value = [attributes objectForKey:key];
		[attr appendFormat:@" %@=\"%@\"", key, value];
	}
	[self appendFormat:@"<%@%@>%@</%@>\n", tag, attr, contents, tag];
	[attr release];
}

- (void) appendOpeningTag:(NSString *)tag attributes:(NSDictionary *)attributes indent:(int)indent {
	if (!tag) {
		return;
	}
	for (int i = 0; i < indent; i++) {
		[self appendString:@"\t"];
	}
	NSMutableString *attr = [[NSMutableString alloc] init];
	int count = [attributes count];
	for (int i = 0; i < count; i++) {
		NSString *key = [[attributes allKeys] objectAtIndex:i];
		NSString *value = [attributes objectForKey:key];
		[attr appendFormat:@" %@=\"%@\"", key, value];
	}
	[self appendFormat:@"<%@%@>\n", tag, attr];
	[attr release];
}

- (void) appendClosingTag:(NSString*)tag indent:(int)indent {
	if (!tag) {
		return;
	}
	for (int i = 0; i < indent; i++) {
		[self appendString:@"\t"];
	}
	[self appendFormat:@"</%@>\n", tag];
}

@end

