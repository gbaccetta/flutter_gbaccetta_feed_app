class MediumRssFeedMocked {
  /// valid article with image
  final string_200 = '''
<rss xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:cc="http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html" version="2.0">
    <channel>
        <title>
            <![CDATA[ Stories by Giovanni Accetta on Medium ]]>
        </title>
        <description>
            <![CDATA[ Stories by Giovanni Accetta on Medium ]]>
        </description>
        <link>https://medium.com/@gbaccetta?source=rss-bc507f75565c------2</link>
        <image>
            <url>https://cdn-images-1.medium.com/fit/c/150/150/0*VgMfq42Wz6e_SgLh</url>
            <title>Stories by Giovanni Accetta on Medium</title>
            <link>https://medium.com/@gbaccetta?source=rss-bc507f75565c------2</link>
        </image>
        <generator>Medium</generator>
        <lastBuildDate>Sat, 18 Mar 2023 12:06:47 GMT</lastBuildDate>
        <atom:link href="https://medium.com/@gbaccetta/feed" rel="self" type="application/rss+xml"/>
        <webMaster>
            <![CDATA[ yourfriends@medium.com ]]>
        </webMaster>
        <atom:link href="http://medium.superfeedr.com" rel="hub"/>
        <item>
            <title>
                <![CDATA[ TeamSpot — A sport team management app built with Flutter and Firebase ]]>
            </title>
            <link>https://gbaccetta.medium.com/teamspot-a-sport-team-management-app-built-with-flutter-and-firebase-e1131f7c0355?source=rss-bc507f75565c------2</link>
            <guid isPermaLink="false">https://medium.com/p/e1131f7c0355</guid>
            <category>
                <![CDATA[ team-management-app ]]>
            </category>
            <category>
                <![CDATA[ event-management-app ]]>
            </category>
            <category>
                <![CDATA[ team-management ]]>
            </category>
            <category>
                <![CDATA[ apps ]]>
            </category>
            <category>
                <![CDATA[ flutter ]]>
            </category>
            <dc:creator>
                <![CDATA[ Giovanni Accetta ]]>
            </dc:creator>
            <pubDate>Tue, 26 Oct 2021 04:07:52 GMT</pubDate>
            <atom:updated>2021-10-26T04:07:52.798Z</atom:updated>
            <content:encoded>
                <![CDATA[ <h3>TeamSpot — A sport team management app built with Flutter and Firebase</h3><img src="https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=e1131f7c0355" width="1" height="1" alt=""> ]]>
            </content:encoded>
        </item>
    </channel>
</rss>
''';
  /// empty list of articles
  final string_200_2 = '''
<rss xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:cc="http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html" version="2.0">
        <channel>
        <title>
            <![CDATA[ Stories by Giovanni Accetta on Medium ]]>
        </title>
    </channel>
</rss>
''';

  //valid article without image
  final string_200_3 = '''
<rss xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:cc="http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html" version="2.0">
    <channel>
        <title>
            <![CDATA[ Stories by Giovanni Accetta on Medium ]]>
        </title>
        <description>
            <![CDATA[ Stories by Giovanni Accetta on Medium ]]>
        </description>
        <link>https://medium.com/@gbaccetta?source=rss-bc507f75565c------2</link>
        <image>
            <url>https://cdn-images-1.medium.com/fit/c/150/150/0*VgMfq42Wz6e_SgLh</url>
            <title>Stories by Giovanni Accetta on Medium</title>
            <link>https://medium.com/@gbaccetta?source=rss-bc507f75565c------2</link>
        </image>
        <generator>Medium</generator>
        <lastBuildDate>Sat, 18 Mar 2023 12:06:47 GMT</lastBuildDate>
        <atom:link href="https://medium.com/@gbaccetta/feed" rel="self" type="application/rss+xml"/>
        <webMaster>
            <![CDATA[ yourfriends@medium.com ]]>
        </webMaster>
        <atom:link href="http://medium.superfeedr.com" rel="hub"/>
        <item>
          <title>
          <![CDATA[ Flutter Enum — How to exchange values with your Backend and/or your app UI since Dart 2.6 ]]>
          </title>
          <link>https://gbaccetta.medium.com/flutter-enum-how-to-exchange-values-with-your-backend-and-or-your-app-ui-since-dart-2-6-bbbe28ea58a?source=rss-bc507f75565c------2</link>
          <guid isPermaLink="false">https://medium.com/p/bbbe28ea58a</guid>
          <category>
          <![CDATA[ enum ]]>
          </category>
          <dc:creator>
          <![CDATA[ Giovanni Accetta ]]>
          </dc:creator>
          <pubDate>Thu, 08 Apr 2021 01:01:47 GMT</pubDate>
          <atom:updated>2021-04-19T18:50:57.968Z</atom:updated>
          <cc:license>http://creativecommons.org/publicdomain/zero/1.0/</cc:license>
          <content:encoded>
          <![CDATA[ <h3>Flutter Enum — How to exchange values with your Backend and/or your app UI since Dart 2.6 thanks to extensions</h3><h3>Introduction</h3>]]>
          </content:encoded>
        </item>
        <item>
            <title>
                <![CDATA[ TeamSpot — A sport team management app built with Flutter and Firebase ]]>
            </title>
            <link>https://gbaccetta.medium.com/teamspot-a-sport-team-management-app-built-with-flutter-and-firebase-e1131f7c0355?source=rss-bc507f75565c------2</link>
            <guid isPermaLink="false">https://medium.com/p/e1131f7c0355</guid>
            <category>
                <![CDATA[ team-management-app ]]>
            </category>
            <dc:creator>
                <![CDATA[ Giovanni Accetta ]]>
            </dc:creator>
            <pubDate>Tue, 26 Oct 2021 04:07:52 GMT</pubDate>
            <atom:updated>2021-10-26T04:07:52.798Z</atom:updated>
            <content:encoded>
                <![CDATA[ <h3>TeamSpot — A sport team management app built with Flutter and Firebase</h3><img src="https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=e1131f7c0355" width="1" height="1" alt=""> ]]>
            </content:encoded>
        </item>
    </channel>
</rss>
''';
}
