##### identify checkbox status

```javascript
$("checkbox").is(':checked') //=> true / false

this.checked //=> true / false
```
##### Global Variable

```javascript
$.global_variable
```

##### js string match

```javascript
"abc".includes("a") //=> true

"abc".match("/\d+/") //=> false
```

##### get class name

``` javascript
$("#id").attr("class") //=> class name
```
##### PJAX

https://github.com/rails/pjax_rails

```ruby
gem 'pjax_rails'
```

```javascript
//application.js
//= require pjax

$(function() {
  $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
});
```

```html
<!-- view -->
<div data-pjax-container>
</div>
```

##### Select2 -- Jquery Remote Data Fetch Select Box

Example: https://select2.github.io/examples.html
Doc: https://select2.github.io/options.html#ajax

##### Choosen -- Customize Select Box

http://harvesthq.github.io/chosen/



