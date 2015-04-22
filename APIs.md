##### Google Event Tracking

https://developers.google.com/analytics/devguides/collection/gajs/eventTrackerGuide#SettingUpEventTracking

```javascript
//trackEvent | category | action | value 
_gaq.push(['_trackEvent', 'Videos', 'Play', 'Gone With the Wind']);

//init tracking
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-XXXXX-X']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
```
##### Google Ecommerce URL Params

https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters

https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide

https://developers.google.com/analytics/devguides/collection/protocol/v1/reference

*params sample*
```
_j1              (&jid) 
analytics_debug.js:9 adSenseId        (&a)   1861155851
analytics_debug.js:9 apiVersion       (&v)   1
analytics_debug.js:9 clientId         (&cid) 165738837.1428094494
analytics_debug.js:9 ec:affiliation   (&ta)  Acme Clothing
analytics_debug.js:9 ec:id            (&ti)  1234
analytics_debug.js:9 ec:revenue       (&tr)  11.99
analytics_debug.js:9 ec:shipping      (&ts)  5
analytics_debug.js:9 ec:tax           (&tt)  1.29
analytics_debug.js:9 encoding         (&de)  UTF-8
analytics_debug.js:9 flashVersion     (&fl)  17.0 r0
analytics_debug.js:9 hitType          (&t)   transaction
analytics_debug.js:9 javaEnabled      (&je)  1
analytics_debug.js:9 language         (&ul)  en-us
analytics_debug.js:9 location         (&dl)  http://amen.epoc.in/items
analytics_debug.js:9 screenColors     (&sd)  24-bit
analytics_debug.js:9 screenResolution (&sr)  1680x1050
analytics_debug.js:9 title            (&dt)  The Best Fashion Sales and Promo Code Deals All in One Place
analytics_debug.js:9 trackingId       (&tid) UA-XXXXXXXXX-1
analytics_debug.js:9 viewportSize     (&vp)  1665x937
analytics_debug.js:9 
Sent beacon:
v=1&_v=j35d&a=1861155851&t=item&_s=2&dl=http%3A%2F%2Famen.epoc.in%2Fitems&ul=en-us&de=UTF-8&dt=The%20Best%20Fashion%20Sales%20and%20Promo%20Code%20Deals%20All%20in%20One%20Place&sd=24-bit&sr=1680x1050&vp=1665x937&je=1&fl=17.0%20r0&_u=CCEAAAIRI~&jid=&cid=165738837.1428094494&tid=UA-XXXXXXXXX-1&ti=1234&in=Fluffy%20Pink%20Bunnies&ic=DD23444&iv=Party%20Toys&ip=11.99&iq=1&z=821033309



_j1               (&jid) 
analytics_debug.js:9 adSenseId         (&a)   1861155851
analytics_debug.js:9 apiVersion        (&v)   1
analytics_debug.js:9 clientId          (&cid) 165738837.1428094494
analytics_debug.js:9 ec:id             (&ti)  1234
analytics_debug.js:9 ec:item code      (&ic)  DD23444
analytics_debug.js:9 ec:item name      (&in)  Fluffy Pink Bunnies
analytics_debug.js:9 ec:item price     (&ip)  11.99
analytics_debug.js:9 ec:item quantity  (&iq)  1
analytics_debug.js:9 ec:item variation (&iv)  Party Toys
analytics_debug.js:9 encoding          (&de)  UTF-8
analytics_debug.js:9 flashVersion      (&fl)  17.0 r0
analytics_debug.js:9 hitType           (&t)   item
analytics_debug.js:9 javaEnabled       (&je)  1
analytics_debug.js:9 language          (&ul)  en-us
analytics_debug.js:9 location          (&dl)  http://amen.epoc.in/items
analytics_debug.js:9 screenColors      (&sd)  24-bit
analytics_debug.js:9 screenResolution  (&sr)  1680x1050
analytics_debug.js:9 title             (&dt)  The Best Fashion Sales and Promo Code Deals All in One Place
analytics_debug.js:9 trackingId        (&tid) UA-XXXXXXXXX-1
analytics_debug.js:9 viewportSize      (&vp)  1665x937
```
