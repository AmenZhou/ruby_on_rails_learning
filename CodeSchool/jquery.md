### Ajax

```js
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    $.ajax($('form').attr('action'), {
      type: $('form').attr('method'),
      data: $('form').serialize(),
      dataType: 'json',
      success: function(response) {
        $('.tour').html('<p></p>')
                  .find('p')
                  .append('Trip to ' + response.description)
                  .append(' at $' + response.price)
                  .append(' for ' + response.nights + ' nights')
                  .append('. Confirmation: ' + response.confirmation);
      }
    });
  });
});
```

**$.map()**
```js
$('button').on('click', function() {
  $.ajax('/cities/deals', {
    contentType: 'application/json',
    dataType: 'json',
    success: function(result) {
      $.each(result, function(index, dealItem) {
        var dealElement = $('.deal-' + index);
        dealElement.find('.name').html(dealItem.name);
        dealElement.find('.price').html(dealItem.price);
      });
    }
  });
});
```

**detach()**
```js
$('.update-available-flights').on('click', function() {
  $.getJSON('/flights/late', function(result) {
    var flightElements = $.map(result, function(flightItem, index){
      var flightEl = $('<li>'+flightItem.flightNumber+'-'+flightItem.time+'</li>');
      return flightEl;
    });
    $('.flight-times').detach().html(flightElements).appendTo(".flights");
  });
});
```

**remove handler and namespace**
```js
$(document).ready(function(){
  // Get Weather
  $('button').on('click.weather', function() {
    var results = $(this).closest('li').find('.results');
    results.append('<p>Weather: 74&deg;</p>');
    $(this).off('click.weather');
  });
  
   // Show Photos
  $('button').on('click.photos', function() {
    var tour = $(this).closest('li');
    var results = tour.find('.results');
    results.append('<p><img src="/assets/photos/'+tour.data('loc')+'.jpg" /></p>');
    $(this).off('click.photos');
  });
});
```

### Plugin

```js
$.fn.photofy = function() {
  this.each(function() {
    var tour = $(this);
    tour.on('click.photofy', '.see-photos', function(e){
      e.preventDefault();
      tour.addClass('is-showing-photofy');
    });
  });
}

$(document).ready(function() {
  $('.tour').photofy();
});
```

```js
$.fn.photofy = function(options) {
  this.each(function() {
    var show = function(e) {
      e.preventDefault();
      settings.tour
              .addClass('is-showing-photofy')
              .find('.photos')
              .find('li:gt('+(settings.count-1)+')')
              .hide();
    }
    var settings = $.extend({
      count: 3,
      tour: $(this)
    }, options);
    settings.tour.on('click.photofy', '.see-photos', show);
    settings.tour.on('show.photofy', show);
  });
}

$(document).ready(function() {
  $('.tour').photofy({ count: 1});
  
  $('.show-photos').on('click', function(e) {
    e.preventDefault();
    // Trigger `show.photofy`
    $('.see-photos').trigger('show.photofy')
  });
});
```

```js
$.fn.photofy = function(options) {
  this.each(function() {
    var show = function(e) {
      e.preventDefault();
      settings.tour
              .addClass('is-showing-photofy')
              .find('.photos')
              .find('li:gt('+(settings.count-1)+')')
              .hide();
    }
    var remove = function(e) {
      e.preventDefault();
      settings.tour.fadeOut().off('.photofy');
    }
    
    var settings = $.extend({
      count: 3,
      tour: $(this)
    }, options);
    settings.tour.on('click.photofy', '.see-photos', show);
    settings.tour.on('click.photofy', '.hide-tour', remove);
    settings.tour.on('show.photofy', show);
  });
}

$(document).ready(function() {
  $('.tour').photofy({ count: 1});
  
  $('.show-photos').on('click', function(e) {
    e.preventDefault();
    $('.tour').trigger('show.photofy');
  });
});
```

###Promise

`vacation.js`

```js
var Vacation = {
  getPrice: function(location){
    var promise = $.Deferred();
    $.ajax('/vacation/prices', {
      data: {q: location},
      success: function(result){
        promise.resolve(result.price);
      },
      error: function(){
        var error = 'invalid location';
        promise.reject(error);
      }
    });
    return promise;
  }
}
```

`application.js`

```js
$(document).ready(function() {
  $('button').on('click', function(){
    var location = $('.location').text();
    Vacation.getPrice(location).done(function(result){
      $('.price').text(result);
    }).fail(function(error){
      console.log(error);
    });
  });
});
```

**Two Ajaxes**

```js
$(document).ready(function() {
  $('button').on('click', function(){
    var tour = $(this).parent();
    var location = tour.data('location');
    var resultDiv = tour.find('.results').empty();
    
    $.when(
      Vacation.getPrice(location),
      Photo.getPhoto(location)
    ).then(
      function(priceResult, photoResult){
        $('<p>$'+priceResult+'</p>').appendTo(resultDiv);
        $('<img />').attr('src', photoResult).appendTo(resultDiv);
      }
    )
  });
});
```

###CoffeeScript

**switch case**
```coffee
# if (newLevel === 1) {
#   message = 'Out of bed yet?';
# } else if (newLevel === 2) {
#   message = 'Good morning!';
# } else {
#   message = 'You should stop while you can';
# }

message = switch newLevel
  when 1 then 'Out of bed yet?'
  when 2 then 'Good morning!'
  else 'You should stop while you can'
```

**present expression**
```coffee
# if (typeof newLevel !== "undefined" && newLevel !== null){
#   checkLevel(newLevel);
# } else {
#   resetLevel();
# }

if newLevel? then checkLevel newLevel else resetLevel
```

**splat arguments**

```coffee
displayTopPicks = (bestCoffee, suggested...) ->
  alert('Top #1 ' + bestCoffee)
  alert('Suggested: ' + suggested.join(", "))
```

**for in when**

```coffee
#   url: '/coffeeList',
#   method: 'GET',
#   success: function(results) {
#     var i = null
#       , coffee = null;
#     for (i = 0; i < results.length; i++) {
#       coffee = results[i];
#       if (coffee.level > 3) {
#         $('ul.drink').append("<li>" + coffee.name + "</li>")
#       }
#     }
#   },
#   error: function(results) {
#     alert("failure " + results);
#   }
# });

$.ajax
  url: '/coffeeList'
  method: 'GET'
  success: (results) ->
    $('ul.drink').append "<li>#{coffee.name}</li>" for coffee in results when coffee.level > 3
  error: (results) ->
    alert("failure #{results}")
```

###EmberJs

```html
<!DOCTYPE html>
<html>
<head>
  <base href='http://courseware.codeschool.com/ember/' />
  <link href='bootstrap.css' rel='stylesheet' />
  <link href='application.css' rel='stylesheet' />
  <script src='jquery.js'></script>
  <script src='handlebars.js'></script>
  <script src='ember.js'></script>
  <script src='ember-data.js'></script>
  <script src='app.js'></script>
</head>
<body>
  <script type='text/x-handlebars' data-template-name='application'>
    <div class='navbar navbar-default'>
      <div class='container'>
        <a href='#' class='navbar-brand'><img src='images/logo.png' alt='logo' height='34' width='224' /></a>
        <ul class='nav navbar-nav navbar-right'>
          <li href='#' class='active'>Home</li>
          <li href='#/about'>About</li>
        </ul>
      </div>
    </div>
      <div class='container'>
        {{outlet}}
      </div>
    <footer class='container'>
      <hr />
      <p class='pull-left'>&copy; 2013 The Flint &amp; Flame</p>
      <p class='pull-right'><a href='#/credits'>Credits</a></p>
    </footer>
  </script>
  <script type='text/x-handlebars' data-template-name='index'>
      <h1>Welcome to The Flint &amp; Flame!</h1>
  </script>
</body>
</html>
```

**Router**
```js
var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});

App.Router.map(function(){
  this.route('about')
})
```

**link**
```html
 <div class='container'>
    {{#link-to 'index' class='navbar-brand'}}<img src='images/logo.png' alt='logo' height='34' width='224' />{{/link-to}}
    <ul class='nav navbar-nav navbar-right'>
      {{#link-to 'index' tagName='li'}}Home{{/link-to}}
      {{#link-to 'about' tagName='li'}}About{{/link-to}}
    </ul>
  </div>
```

**Property**

app.js
```js
var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
App.Router.map(function() {
  this.route('credits', { path: '/thanks' });
  this.route('about');
});
App.IndexController = Ember.Controller.extend({
  productsCount: 6,
  logo: 'images/logo-small.png',
  time: function(){
    return (new Date()).toDateString();
  }.property()
})
```
index.html
```html
{{productsCount}}
<img {{bind-attr src='logo'}} />
{{time}}
```

**fetch model object and do loop**
```html
<script type='text/x-handlebars' data-template-name='products'>
  {{#each}}
    {{title}}
    <img {{bind-attr src='image'}} />
  {{/each}}
</script>
```

```js
var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
App.Router.map(function() {
  this.route('credits', { path: '/thanks' });
  this.route('about');
  this.resource('products');
});
App.IndexController = Ember.Controller.extend({
  productsCount: 6,
  logo: 'images/logo-small.png',
  time: function() {
    return (new Date()).toDateString();
  }.property()
});
App.AboutController = Ember.Controller.extend({
  contactName: 'Anostagia',
  avatar: 'images/avatar.png',
  open: function() {
    return ((new Date()).getDay() === 0) ? "Closed" : "Open";
  }.property()
});
App.ProductsRoute = Ember.Route.extend({
  model: function(){
    return App.PRODUCTS;
  }
})
App.PRODUCTS = [
  {
    title: "Flint",
    price: "800",
    description: "2016 new",
    isOnSale: true,
    image: 'images/products/flint.png'
  },
  {
    title: "Kindling",
    price: "100",
    description: "New style",
    isOnSale: false,
    image: 'images/products/kindling.png'
  }
]
```

**Nested**
```js
var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
App.Router.map(function() {
  this.route('credits', { path: '/thanks' });
  //this.route('about');
  this.resource('products', function() {
    this.resource('product', { path: '/:title' });
  });
  this.resource('contacts', function(){
    this.resource('contact', { path: '/:name' });
  });
});

App.IndexController = Ember.Controller.extend({
  productsCount: 6,
  logo: 'images/logo-small.png',
  time: function() {
    return (new Date()).toDateString();
  }.property()
});
App.ContactsIndexController = Ember.Controller.extend({
  contactName: 'Anostagia',
  avatar: 'images/avatar.png',
  open: function() {
    return ((new Date()).getDay() === 0) ? "Closed" : "Open";
  }.property()
});

App.ProductsRoute = Ember.Route.extend({
  model: function() {
    return App.PRODUCTS;
  }
});
App.ProductRoute = Ember.Route.extend({
  model: function(params) {
    return App.PRODUCTS.findBy('title', params.title); 
  }
});

App.ContactsRoute = Ember.Route.extend({
  model: function() {
    return App.CONTACTS;
  }
});
App.ContactRoute = Ember.Route.extend({
  model: function(params) {
    return App.CONTACTS.findBy('name', params.name);
  }
});

App.PRODUCTS = [
  {
    title: 'Flint',
    price: 99,
    description: 'Flint is a hard, sedimentary cryptocrystalline form of the mineral quartz, categorized as a variety of chert.',
    isOnSale: true,
    image: 'images/products/flint.png'
  },
  {
    title: 'Kindling',
    price: 249,
    description: 'Easily combustible small sticks or twigs used for starting a fire.',
    isOnSale: false,
    image: 'images/products/kindling.png'
  }
];

App.CONTACTS = [
  {
    name: 'Giamia',
    about: 'Although Giamia came from a humble spark of lightning, he quickly grew to be a great craftsman, providing all the warming instruments needed by those close to him.',
    avatar: 'images/contacts/giamia.png'
  },
  {
    name: 'Anostagia',
    about: 'Knowing there was a need for it, Anostagia drew on her experience and spearheaded the Flint & Flame storefront. In addition to coding the site, she also creates a few products available in the store.',
    avatar: 'images/contacts/anostagia.png'
  }
];
```

**Fixture**
```js
var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
App.Router.map(function() {
  this.route('credits', { path: '/thanks' });
  this.resource('products', function() {
    this.resource('product', { path: '/:product_id' });
  });
  this.resource('contacts', function() {
    this.resource('contact', { path: '/:name' });
  });
});
App.IndexController = Ember.Controller.extend({
  productsCount: 6,
  logo: 'images/logo-small.png',
  time: function() {
    return (new Date()).toDateString();
  }.property()
});
App.ContactsIndexController = Ember.Controller.extend({
  contactName: 'Anostagia',
  avatar: 'images/avatar.png',
  open: function() {
    return ((new Date()).getDay() === 0) ? "Closed" : "Open";
  }.property()
});

App.ProductsRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('product');
  }
});

App.ContactsRoute = Ember.Route.extend({
  model: function() {
    return App.CONTACTS;
  }
});
App.ContactRoute = Ember.Route.extend({
  model: function(params) {
    return App.CONTACTS.findBy('name', params.name);
  }
});

App.CONTACTS = [
  {
    name: 'Giamia',
    about: 'Although Giamia came from a humble spark of lightning, he quickly grew to be a great craftsman, providing all the warming instruments needed by those close to him.',
    avatar: 'images/contacts/giamia.png'
  },
  {
    name: 'Anostagia',
    about: 'Knowing there was a need for it, Anostagia drew on her experience and spearheaded the Flint & Flame storefront. In addition to coding the site, she also creates a few products available in the store.',
    avatar: 'images/contacts/anostagia.png'
  }
];

App.Product = DS.Model.extend({
    title: DS.attr('string'),
    price: DS.attr('number'),
    description: DS.attr('string'),
    isOnSale: DS.attr('boolean'),
    image: DS.attr('string')
})

App.Product.FIXTURES = [
  {
    id: 1,
    title: 'Flint',
    price: 99,
    description: 'Flint is a hard, sedimentary cryptocrystalline form of the mineral quartz, categorized as a variety of chert.',
    isOnSale: true,
    image: 'images/products/flint.png'
  },
  {
    id: 2,
    title: 'Kindling',
    price: 249,
    description: 'Easily combustible small sticks or twigs used for starting a fire.',
    isOnSale: false,
    image: 'images/products/kindling.png'
  }
];

App.ProductRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('product', params.product_id);
  }
});

App.ApplicationAdapter = DS.FixtureAdapter.extend();
```
