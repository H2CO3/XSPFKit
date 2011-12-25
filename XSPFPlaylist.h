/*
  XSPFPlaylist.h
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import <Foundation/Foundation.h>
#import "XSPFTrack.h"


@interface XSPFPlaylist: NSObject {
	NSString *title;
	NSString *author;
	NSString *comment;
	NSURL *info;
	NSURL *location;
	NSString *identifier;
	NSURL *image;
	NSString *date;
	NSURL *license;
	NSMutableArray *links;
	NSMutableArray *meta;
	NSMutableArray *trackList;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSURL *info;
@property (nonatomic, retain) NSURL *location;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSURL *image;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSURL *license;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *meta;
@property (nonatomic, retain) NSMutableArray *trackList;

+ (id) playlist;

@end

