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

##### JQuery Animation Example
```javascript
  $('.product-quick-add-btn').on('click', function(e) {
      $(".menu-cart-empty").removeClass("menu-cart-empty-show");
      $(".badge").text("5");
      e.preventDefault();
      var cart = $('.fa-shopping-cart');
      var $imgtodrag = $(this).parents(".product-item");
      if ($imgtodrag) {
          var imgclone = $imgtodrag.clone()
              .offset({
                  top: $imgtodrag.offset().top,
                  left: $imgtodrag.offset().left
              })
              .css({
                  'opacity': '0.5',
                  'position': 'absolute',
                  'height': '150px',
                  'width': '150px',
                  'z-index': '3000'
              })
              .appendTo($('body'))
              .animate({
                  'top': cart.offset().top + 10,
                  'left': cart.offset().left,
                  'width': 75,
                  'height': 75
              }, 1000, 'linear');

          imgclone.animate({
              'width': 0,
              'height': 0
          }, function() {
              $(this).detach()
          }).find("i, .product-quick-details, .product-quick-add-btn, .product-label").remove();
      }
      setTimeout(function() {
          $(".menu-cart-preview").addClass("menu-cart-preview-show");
      }, 1500);
  });
```
