/*
  XSPFManager.m
  XSPFKit
  
  Created by Árpád Goretity on 23/12/2011.
  Licensed under a CreativeCommons Attribution 3.0 Unported License
*/

#import "XSPFManager.h"
#import "NSMutableString+XSPFKit.h"


static id shared = NULL;

@implementation XSPFManager

/* Singleton */

+ (id) sharedInstance {
	if (shared == NULL) {
		shared = [[self alloc] init];
	}
	return shared;
}

/* Parsing XSPF data */

- (XSPFPlaylist *) playlistFromFile:(NSString *)file {
	NSURL *url = [NSURL fileURLWithPath:file];
	XSPFPlaylist *result = [self playlistFromUrl:url];
	return result;
}

- (XSPFPlaylist *) playlistFromUrl:(NSURL *)url {
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	xmlParser.delegate = self;
	[xmlParser parse];
	[xmlParser release];
	return playlist;
}

- (XSPFPlaylist *) playlistFromString:(NSString *)string {
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	XSPFPlaylist *result = [self playlistFromData:data];
	return result;
}

- (XSPFPlaylist *) playlistFromData:(NSData *)data {
	xmlParser = [[NSXMLParser alloc] initWithData:data];
	xmlParser.delegate = self;
	[xmlParser parse];
	[xmlParser release];
	return playlist;
}

/* Generating XSPF data */

- (NSString *) stringFromPlaylist:(XSPFPlaylist *)pl {
	NSMutableString *str = [NSMutableString string];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[str appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
	[str appendOpeningTag:@"playlist" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@"http://xspf.org/ns/0", @"xmlns", @"1", @"version", NULL] indent:0];
	[str appendTag:@"title" contents:pl.title attributes:NULL indent:1];
	[str appendTag:@"creator" contents:pl.author attributes:NULL indent:1];
	[str appendTag:@"annotation" contents:pl.comment attributes:NULL indent:1];
	[str appendTag:@"info" contents:[pl.info absoluteString] attributes:NULL indent:1];
	[str appendTag:@"location" contents:[pl.location absoluteString] attributes:NULL indent:1];
	[str appendTag:@"identifier" contents:pl.identifier attributes:NULL indent:1];
	[str appendTag:@"image" contents:[pl.image absoluteString] attributes:NULL indent:1];
	[str appendTag:@"date" contents:pl.date attributes:NULL indent:1];
	[str appendTag:@"license" contents:[pl.license absoluteString] attributes:NULL indent:1];
	for (int i = 0; i < [pl.links count]; i++) {
		[str appendTag:@"link" contents:[(NSURL *)[pl.links objectAtIndex:i] absoluteString] attributes:NULL indent:1];
	}
	for (int i = 0; i < [pl.meta count]; i++) {
		[str appendTag:@"meta" contents:[pl.meta objectAtIndex:i] attributes:NULL indent:1];
	}
	[str appendOpeningTag:@"trackList" attributes:NULL indent:1];
	for (int i = 0; i < [pl.trackList count]; i++) {
		XSPFTrack *tr = [pl.trackList objectAtIndex:i];
		[str appendOpeningTag:@"track" attributes:NULL indent:2];
		[str appendTag:@"location" contents:[tr.location absoluteString] attributes:NULL indent:3];
		[str appendTag:@"identifier" contents:tr.identifier attributes:NULL indent:3];
		[str appendTag:@"title" contents:tr.title attributes:NULL indent:3];
		[str appendTag:@"creator" contents:tr.author attributes:NULL indent:3];
		[str appendTag:@"annotation" contents:tr.comment attributes:NULL indent:3];
		[str appendTag:@"info" contents:[tr.info absoluteString] attributes:NULL indent:3];
		[str appendTag:@"image" contents:[tr.image absoluteString] attributes:NULL indent:3];
		[str appendTag:@"album" contents:tr.album attributes:NULL indent:3];
		[str appendTag:@"trackNum" contents:[tr.trackNumber stringValue] attributes:NULL indent:3];
		[str appendTag:@"duration" contents:[tr.duration stringValue] attributes:NULL indent:3];
		for (int j = 0; j < [tr.links count]; j++) {
			[str appendTag:@"link" contents:[(NSURL *)[tr.links objectAtIndex:j] absoluteString] attributes:NULL indent:3];
		}
		for (int j = 0; j < [tr.meta count]; j++) {
			[str appendTag:@"meta" contents:[tr.meta objectAtIndex:j] attributes:NULL indent:3];
		}
		[str appendClosingTag:@"track" indent:2];
	}
	[str appendClosingTag:@"trackList" indent:1];
	[str appendClosingTag:@"playlist" indent:0];
	[pool release];
	return str;
}

- (NSData *) dataFromPlaylist:(XSPFPlaylist *)pl {
	NSData *result = [[self stringFromPlaylist:pl] dataUsingEncoding:NSUTF8StringEncoding];
	return result;
}

/* NSXMLParserDelegate */

- (void) parserDidStartDocument:(NSXMLParser *)parser {
	tagStack = [[NSMutableArray alloc] init];
	tagPath = [[NSMutableString alloc] initWithString:@"/"];
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
	[tagStack release];
	[tagPath release];
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)error {
	[tagStack release];
	[tagPath release];
	playlist = NULL;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)element namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributes {
	if ([element isEqualToString:@"playlist"]) {
		playlist = [XSPFPlaylist playlist];
	} else if ([element isEqualToString:@"track"]) {
		track = [[XSPFTrack alloc] init];
	}
	NSMutableDictionary *context = [[NSMutableDictionary alloc] init];
	[context setObject:attributes forKey:@"attributes"];
	NSMutableString *text = [[NSMutableString alloc] init];
	[context setObject:text forKey:@"text"];
	[text release];
	[tagStack addObject:context];
	[context release];
	[tagPath appendPathComponent:element];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)element namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
	NSMutableDictionary *context = [tagStack lastObject];
	NSMutableString *text = [context objectForKey:@"text"];
	NSDictionary *attributes = [context objectForKey:@"attributes"];
	if ([tagPath isEqualToString:@"/playlist/title"]) {
		playlist.title = text;
	} else if ([tagPath isEqualToString:@"/playlist/creator"]) {
		playlist.author = text;
	} else if ([tagPath isEqualToString:@"/playlist/annotation"]) {
		playlist.comment = text;
	} else if ([tagPath isEqualToString:@"/playlist/info"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		playlist.info = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/location"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		playlist.location = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/identifier"]) {
		playlist.identifier = text;
	} else if ([tagPath isEqualToString:@"/playlist/image"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		playlist.image = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/date"]) {
		playlist.date = text;
	} else if ([tagPath isEqualToString:@"/playlist/license"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		playlist.license = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/link"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		[playlist.links addObject:url];
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/meta"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		[playlist.meta addObject:url];
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/location"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		track.location = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/identifier"]) {
		track.identifier = text;
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/title"]) {
		track.title = text;
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/creator"]) {
		track.author = text;
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/annotation"]) {
		track.comment = text;
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/info"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		track.info = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/image"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		track.image = url;
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/album"]) {
		track.album = text;
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/trackNum"]) {
		NSNumber *num = [[NSNumber alloc] initWithInt:[text intValue]];
		track.trackNumber = num;
		[num release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/duration"]) {
		NSNumber *num = [[NSNumber alloc] initWithInt:[text intValue]];
		track.duration = num;
		[num release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/link"]) {
		NSURL *url = [[NSURL alloc] initWithString:text];
		[track.links addObject:url];
		[url release];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track/meta"]) {
		[track.meta addObject:text];
	} else if ([tagPath isEqualToString:@"/playlist/trackList/track"]) {
		[playlist.trackList addObject:track];
		[track release];
	}
	[tagStack removeLastObject];
	[tagPath deleteLastPathComponent];
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSMutableDictionary *context = [tagStack lastObject];
	NSMutableString *text = [context objectForKey:@"text"];
	[text appendString:string];
}

- (void) parser:(NSXMLParser *)parser foundCDATA:(NSData *)data {
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSMutableDictionary *context = [tagStack lastObject];
	NSMutableString *text = [context objectForKey:@"text"];
	[text appendString:string];
	[string release];
}

@end

