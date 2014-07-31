Working on Sms Project -- 06/06/14

=======================================

###Sms -- 

1 'protect_from_forgery with: :exception' this sentence means the app requires all the POST http requests must have auth_token, if want to skip it , can use 'skip_before_filter :verify_authenticity_token, only: :send_callback'

2  if want to receive message sending status callback, must set the 'send_callback' action except, so add this into the action controller 'before_action :authenticate_admin! except: :send_callback'

==================================================

###brm

issue -- Universal Updates to top Navigation Bar #5

javascript get ruby variable -- action = "#{action_name}"

data_action -- li data-action='filter'

javascript @ slim must add '- content_for :bottom' line

===================================================

###Brm -- Issue

Solved

profile - my profile is linked to new action

profile - new and edit action render partial

profile - edit action error

================================================

###Brm

[Solved] profile - edit page, save the result then go to create action

[Solved] profile - can't show checkbox inside form

[Solved] profile - checkbox 'f.check_box :grades, {:multiple => true}, grade.name, false'

[Solved] profile - save multiple checkbox value -     

controller 
```ruby
params.require(:profile).permit(:user_id, :sex, :school,
                                    :zipcode, :grades_taught, :about,
                                    :experience, :special, :avatar, :grade_ids => [])
```
view
``` ruby
- Grade.all.each do |grade|
  | "#{grade.name}"
  = check_box_tag "profile[grade_ids][]", grade.id, @profile.grade_ids.include?(grade.id)              
```
========================================================================

###Brm

[Question] profile -- the text input bars in all forms, the content will be disappeared when it's onfocus. There is block of code to controll it, most_common_tools.js line:105
 
=====================================================================

###Brm

[Question] log in -- log in sucessfully, change redirect to in continaer_login, but failed

Issues

1 #37 fixed -- remove link url of support pic in support detail page

2 #33 -- see TpT_reading.html.obt file

3 #28 fixed a part -- change SHARE link , ref: https://drive.google.com/folderview?id=0BxNoN0cnMPSHMjFoU2RXdlFjQ0U&usp=sharing

4 #25 -- change supports issue https://docs.google.com/document/d/1hASF2BurV0mL51WTWCkCFQGH2JIPpltyLyI_dap9Fxg/edit

5 #19 -- change or add search condition can't affect each others, ref to search students and filter supports

===========================================================================

###Sms 

Install kaminari

split one big page to multiple pages

[Question] crsf can't work in production env -- this related to config/production.rb file
	--[solved] change config/enviroments/production.rb config.serve_static_assets = false
	see http://stackoverflow.com/questions/7829480/no-route-matches-get-assets

=================================================================================

###Brm 

1 #4 #8 need picture

2 #28 add email sending function

3 Coffee in Slim pass ruby variable
```javascript
- content_for :bottom
  javascript:
    var url_path = "#{send_email_supports_path}"
```
==========================================================

###Brm

Email Regular Expression
```
/^(([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4}),?(\s+)?)+$/    
```
Resque

ref: http://railscasts.com/episodes/271-resque

resque status check: 127.0.0.1:5678/overview

===============================================================

###Sms

Jquery Ajax
```javascript
$.ajax({
      type: 'post',
      url: '/respond_checkbox',
      data: {message_id: message_id}
    }).done(function(msg){
      alert(msg);
    });
```
============================================================

###Brm

Jquery get Selected option
```javascript
$( "#skill_topic_select" ).change(function() {
        var str = "";
        str = $(this).children( "select option:selected" ).text();
        $( "small#skill_topic_small").text(str);
      })
      .trigger( "change" ); 
```
==========================================================

###Brm

Search supports by Age Range 

support min age is 'sup_min'
support max age is 'sup_max'

search condition min age is 'age_min'
search condition max age is 'age_max'
```
sup_min <= age_max and sup_max >= age_min
```
=================================================================

###Brm
```ruby
render partial: 'partial_file', locals {loc_var: @ins_var}
```
===============================================================

###Brm

table_for

https://github.com/zlx/tabletastic

```ruby
select_tag "people", options_from_collection_for_select(@people, "id", "name")
```
==============================================================================

###Facebook Gigya API Setting

#####Gigya Setting

https://console.gigya.com/site/partners/Plugins.aspx



######Facebook Setting

http://developers.gigya.com/010_Developer_Guide/82_Socialize_Setup/005_Opening_External_Applications/10_Facebook



###### change gigya api key in application.yml

###### change facebook key and secret key in bash vironment



###### railscast 

http://railscasts.com/episodes/360-facebook-authentication?autoplay=true
