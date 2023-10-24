class MediumRssFeedMocked {
  static const string_200 = '''
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
                <![CDATA[ <h3>TeamSpot — A sport team management app built with Flutter and Firebase</h3><p>I finally got to publish the first version of my new app: “TeamSpot — Join the club !”. TeamSpot is a cross-platform, graphically appealing sport management app, completely free and dedicated to groups of friends or coaches that struggle to schedule and organize games, practices or regular group activities and at the same time keep every one informed and up to date.</p><p>From a developer point of few it is a nice demonstration of Flutter cross-platform capabilities. The first version I published works seamlessly on the web: <a href="https://teamspot.club,">https://teamspot.club,</a> on <a href="https://play.google.com/store/apps/details?id=club.teamspot.app&amp;referrer=utm_source%3Dmedium%26utm_campaign%3Darticle1">android</a> and on <a href="https://click.google-analytics.com/redirect?tid=263484783&amp;url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmy-app%2Fid1587468531&amp;aid=club.teamspot.app&amp;idfa=idfa&amp;cs=medium&amp;cn=article1">iOS</a>. The backend is completely serverless and built in a scalable way using almost all of Firebase services and respecting the clean architecture principle. However, I want this article to be more about TeamSpot and its features than about development. Though I’ll talk a little-bit about it and keep publishing more articles about what I did and how I achieved this result.</p><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*N8jECWhlG50q8eDaIDd7Bw.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*G7CqiqVLNVipmYqxcLXDVA.png" /></figure><h3>Why TeamSpot and what does it do?</h3><p>Almost Everybody has struggled to organize group activities, sports sessions, board games meetups, or any other hangout activity with a regular group of people. Current Messaging solutions such as WhatsApp and Facebook Messenger are not suited to organize events and follow availability quickly. Alternatives are often dedicated to club management and, therefore, too complex and not easy to use. TeamSpot offers a cross-platform simple and graphically appealing solution to help any group of friends (small or big) organize their regular sport or e-sport activities by communicating in the forum, creating events and launching surveys and tracking all members’ responses. TeamSpot also focuses on privacy since members do not need to expose emails or phone numbers to the rest of the group.</p><h4>A focus on privacy: Join a team without sharing your phone number or mail</h4><figure><img alt="" src="https://cdn-images-1.medium.com/max/192/1*9bF82pMhyWfTvTp_UnrxRg.png" /></figure><p>TeamSpot focuses on privacy since members do not need to expose emails or phone numbers to the rest of the group. To join a team you only need a TeamSpot invitation code or a TeamSpot invitation link. Or, if you create a team, just choose a name and a domain (Football, Volleyball, Basketball, e-Sport or any other sport), you can easily invite other players. From the team tab, share with them an invitation link or simply let them scan the QR code. Your phone number and/or mail, as well as those from other players won’t be shared with the others.</p><h4>The TeamSpot forum: a communication tool to stay up to date with everyone</h4><p>The TeamSpot forum act as your team virtual dressing room! Ask any questions, communicate with other players, discuss past games and practices or simply have fun conversation. The TeamSpot forum is the best “Spot” to share your thoughts.</p><h4>TeamSpot events: Schedule your team games and practices keep track of every player response</h4><p>The TeamSpot events tab allows to create a single event as well as weekly or monthly activities. Being it a weekly training session, a single game or some practice time, TeamSpot events allow every player to quickly show their availability to all the team.</p><h4>TeamSpot surveys: Launch surveys to always choose the best option for every player</h4><p>The TeamSpot survey tab allows to create simple survey for your team. You can choose among up to 5 options! Being it choosing a date for your next big game or choosing a place for your team to practice. TeamSpot surveys are the perfect tool to always choose the best option for everybody.</p><h3>The graphics</h3><p>One of the point I really paid attention to has been the look and feel of the app. As you can see from the screenshots below, There is not a single square corner in the app. Also most of the UI components have custom rounded shapes with each angle having a different curve.</p><p>I also tried to put some attention into animations and transitions as these are fundamental blocks to deliver a pleasant user experience.</p><h3>The cross-platform capabilities</h3><p>Being able to build an app that could be used by virtually anyone was one of the main objectives I had.</p><p>In order to achieve that, Flutter has been an almost obvious choice for me. Being alone in developing both the frontend and backend, Flutter was the most comprehensive fast and effective framework that allowed me to publish this first version on the web: <a href="https://teamspot.club,">https://teamspot.club,</a> on <a href="https://play.google.com/store/apps/details?id=club.teamspot.app&amp;referrer=utm_source%3Dmedium%26utm_campaign%3Darticle1">android</a> and on <a href="https://click.google-analytics.com/redirect?tid=263484783&amp;url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmy-app%2Fid1587468531&amp;aid=club.teamspot.app&amp;idfa=idfa&amp;cs=medium&amp;cn=article1">iOS</a> with virtually no extra effort.</p><h3>Some screenshots of the app</h3><p>Visuals let you often understand things more quickly than in any other way:</p><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*N9_ANhvLDM6-Hf_cWunivQ.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*_cHRJNBLyHWhA37zY7PJlA.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*q-JPUDdWwe7KsdKPKA-ekA.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*KSk4UUE8MbKzs3qZ0jgz0Q.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*gcEudy3-dC1Hcip10p_VmA.png" /></figure><figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*F_xEtXTj0JAZMDQZkc-V7w.png" /></figure><h3>Conclusion</h3><p>I hope that you like my new application.</p><p>I would really appreciate if you have any feedback and/or suggestions on how to improve it. Also I would really like to know what feature / part of the app is worth an article to explain the inner working of the feature.</p><p>Finally if you really want to help me just download the app and try using it with one or more of the groups you are into and/or <a href="https://www.buymeacoffee.com/gbaccetta">support me by buying me a coffee.</a></p><img src="https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=e1131f7c0355" width="1" height="1" alt=""> ]]>
            </content:encoded>
        </item>
    </channel>
</rss>
''';
}
