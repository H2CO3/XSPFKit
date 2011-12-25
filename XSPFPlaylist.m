/*
  XSPFPlaylist.m
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import "XSPFPlaylist.h"


@implementation XSPFPlaylist

@synthesize title;
@synthesize author;
@synthesize comment;
@synthesize info;
@synthesize location;
@synthesize identifier;
@synthesize image;
@synthesize date;
@synthesize license;
@synthesize links;
@synthesize meta;
@synthesize trackList;

+ (id) playlist {
	return [[[self alloc] init] autorelease];
}

- (id) init {
	self = [super init];
	NSMutableArray *mLinks = [[NSMutableArray alloc] init];
	self.links = mLinks;
	[mLinks release];
	NSMutableArray *mMeta = [[NSMutableArray alloc] init];
	self.meta = mMeta;
	[mMeta release];
	NSMutableArray *mTrackList = [[NSMutableArray alloc] init];
	self.trackList = mTrackList;
	[mTrackList release];
	return self;
}

- (void) dealloc {
	self.title = NULL;
	self.author = NULL;
	self.comment = NULL;
	self.info = NULL;
	self.location = NULL;
	self.identifier = NULL;
	self.image = NULL;
	self.date = NULL;
	self.license = NULL;
	self.links = NULL;
	self.meta = NULL;
	self.trackList = NULL;
	[super dealloc];
}

@end

