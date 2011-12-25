/*
  XSPFTrack.h
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import <Foundation/Foundation.h>


@interface XSPFTrack: NSObject {
	NSURL *location;
	NSString *identifier;
	NSString *title;
	NSString *author;
	NSString *comment;
	NSURL *info;
	NSURL *image;
	NSString *album;
	NSNumber *trackNumber;
	NSNumber *duration;
	NSMutableArray *links;
	NSMutableArray *meta;
}

@property (nonatomic, retain) NSURL *location;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSURL *info;
@property (nonatomic, retain) NSURL *image;
@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) NSNumber *trackNumber;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *meta;

@end

