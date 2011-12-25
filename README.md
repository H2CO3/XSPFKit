<h1>XSPFKit</h1>
<hr />
<p>
XSPFKit is a simple Objective-C framework to add support for XSPF playlist files.
</p>
<br>
<h2>How to use the framework</h2>
<ol>
  <li><pre><tt><code>#import &lt;XSPFKit/XSPFKit.h&gt;</code></tt></pre></li>
  <li>Use the shared XSPFManager instance along with a file, URL, an XML string or XML data containing an XSPF playlist document to generate an XSPFPlaylist object.</li>
  <li>For example: <code><tt><pre>XSPFPlaylist *playlist = [[XSPFManager sharedInstance] playlistFromFile:@"/User/foo.xspf"];</pre></tt></code></li>
  <li>Or vice versa: <code><tt><pre>NSString *xml = [[XSPFManager sharedInstance] stringFromPlaylist:playlist];</pre></tt></code></li>
  <li>The names of the XSPFPlaylist class are self-explanatory; the <tt>links</tt> property is an NSArray of NSURLs, containing the <tt>&lt;link&gt;</tt> tags of the playlist. The <tt>meta</tt> property is an NSArray of NSStrings, each containing one of the playlist's <tt>&lt;meta&gt;</tt> elements.</li>
  <li>XSPFPlaylist.trackList is an NSArray of XSPFTrack objects (also with obviously named properties). This class' <tt>links</tt> and <tt>meta</tt> properties are identical to that of XSPFPlaylist's.</li>
</ol>

