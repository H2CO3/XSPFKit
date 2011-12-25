/*
  XSPFTrack.m
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import "XSPFTrack.h"


@implementation XSPFTrack

@synthesize location;
@synthesize identifier;
@synthesize title;
@synthesize author;
@synthesize comment;
@synthesize info;
@synthesize image;
@synthesize album;
@synthesize trackNumber;
@synthesize duration;
@synthesize links;
@synthesize meta;

- (id) init {
	self = [super init];
	NSMutableArray *mLinks = [[NSMutableArray alloc] init];
	self.links = mLinks;
	[mLinks release];
	NSMutableArray *mMeta = [[NSMutableArray alloc] init];
	self.meta = mMeta;
	[mMeta release];
	return self;
}

- (void) dealloc {
	self.location = NULL;
	self.identifier = NULL;
	self.title = NULL;
	self.author = NULL;
	self.comment = NULL;
	self.info = NULL;
	self.image = NULL;
	self.album = NULL;
	self.trackNumber = NULL;
	self.duration = NULL;
	self.links = NULL;
	self.meta = NULL;
	[super dealloc];
}

@end

