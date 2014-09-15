Padding not change width


-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
-moz-box-sizing: border-box;    /* Firefox, other Gecko */
box-sizing: border-box; 

ref: http://stackoverflow.com/questions/779434/preventing-padding-propety-from-changing-width-or-height-in-css

=============================================================

Break words to two lines

word-break: break-all

=====================================================

jQuery selector camma

$("tr", "#parent")  -->  find the 'tr' tag inside the '#parent'

same as $("#parent tr")


$(child).parents(parent) --> find the specific 'parent' from all the ancestors

==================================================================

Google map chart api

https://developers.google.com/chart/interactive/docs/gallery/barchart

Map icon

http://www.iconarchive.com/show/vista-map-markers-icons-by-icons-land/Map-Marker-Bubble-Chartreuse-icon.html

### Solve the problem of load google map and chart in rails

[http://stackoverflow.com/questions/14227363/using-turbolinks-in-a-rails-link-to](http://stackoverflow.com/questions/14227363/using-turbolinks-in-a-rails-link-to)

### CSS Hide Arrow of Select Box

```css
 -webkit-appearance:none;
```
 
### CSS Avoid Padding Extend Width

```css
-webkit-box-sizing: border-box;
```
### Show Text Hover Over An Ele

View Page

```ruby
small data-title="#{cog_issue.name}" 
 =cog_issue.name.truncate(14) 
```

CSS
```css
small[data-title]:hover:after{
  content: attr(data-title);
  font-size: 16px;
  background:white;
  padding: 4px 8px;
  color: #333; 
  position: absolute; 
  white-space: nowrap; 
  z-index: 20px; 
  -moz-border-radius: 5px; 
  -webkit-border-radius: 5px; 
  border-radius: 5px; 
  -moz-box-shadow: 0px 0px 4px #222;  
  -webkit-box-shadow: 0px 0px 4px #222;     
  box-shadow: 0px 0px 4px #222;
}
```
### Render a rails partial in js.erb file
```ruby
$("#table_sum").text("").append("<%= j raw render(partial:'summary_row')%>");
```
