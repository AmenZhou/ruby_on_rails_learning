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
