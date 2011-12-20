bedtime
=======

Exposes oEmbed consumer functionality over XMPP.

Installation
------------

npm i bedtime

Usage
-----

    vi config.json
    node ./bin/bedtime.js config.json

Protocol
--------

```xml
<iq to="oembed.example.org" type="get" id="o">
<oembed xmlns="http://github.com/buddycloud/bedtime"
        url="http://www.youtube.com/watch?v=XZ5TajZYW6Y"
        maxwidth="1024"/>
</iq>
```

```xml
<iq from='oembed.example.org' to='astro@spaceboyz.net/lobster/gajim' id='o' type='result'>
  <oembed xmlns='http://github.com/buddycloud/bedtime'>
    <provider_url>http://www.youtube.com/</provider_url>
    <title>Rick Astley - Never Gonna Give You Up ☻(RickRoll&apos;HD)☺</title>
    <html>&lt;iframe width=&quot;612&quot; height=&quot;344&quot; src=&quot;http://www.youtube.com/embed/XZ5TajZYW6Y?fs=1&amp;feature=oembed&quot; frameborder=&quot;0&quot; allowfullscreen&gt;&lt;/iframe&gt;</html>
    <author_name>TrailerForAll</author_name>
    <height>344</height>
    <thumbnail_width>480</thumbnail_width>
    <width>612</width>
    <version>1.0</version>
    <author_url>http://www.youtube.com/user/TrailerForAll</author_url>
    <provider_name>YouTube</provider_name>
    <thumbnail_url>http://i1.ytimg.com/vi/XZ5TajZYW6Y/hqdefault.jpg</thumbnail_url>
    <type>video</type>
    <thumbnail_height>360</thumbnail_height>
  </oembed>
</iq>
```
