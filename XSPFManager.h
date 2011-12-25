/*
  XSPFManager.h
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import <Foundation/Foundation.h>
#import "XSPFPlaylist.h"
#import "XSPFTrack.h"


@interface XSPFManager: NSObject {
	NSXMLParser *xmlParser;
	NSMutableArray *tagStack;
	NSMutableString *tagPath;
	XSPFPlaylist *playlist;
	XSPFTrack *track;
}

+ (id) sharedInstance;

- (XSPFPlaylist *) playlistFromFile:(NSString *)file;
- (XSPFPlaylist *) playlistFromUrl:(NSURL *)url;
- (XSPFPlaylist *) playlistFromString:(NSString *)string;
- (XSPFPlaylist *) playlistFromData:(NSData *)data;

- (NSString *) stringFromPlaylist:(XSPFPlaylist *)pl;
- (NSData *) dataFromPlaylist:(XSPFPlaylist *)pl;

@end

