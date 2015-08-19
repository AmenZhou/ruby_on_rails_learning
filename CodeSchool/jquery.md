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
