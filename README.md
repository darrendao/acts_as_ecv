# acts_as_ecv
acts_as_ecv is a simple ruby gem that helps add ecv (Extended Content Verification) to Rails webapp. This functionality is
necessary for production environment where your servers sit behind a load balancer, and you want the load balancer to do more 
than just a simple ping or tcp check to verify that the app is up and running.

## Installation
It&apos;s hosted on [rubygems.org][rubygems].

    sudo gem install acts_as_ecv

## Usage

```ruby
     # Rails 2.3.x, add this to environment.rb 
     config.gem 'acts_as_ecv'

     # Rails 3, add this to Gemfile
     gem 'acts_as_ecv'

     # Now, create a controller that will serve up the ecv 
     # For example, in ecv_controllers.rb 
     class EcvController < ApplicationController
       acts_as_ecv :up_txt => "SYSTEM UP", :down_txt => "SYSTEM DOWN", :down_file => "file/for/marking/the/app/as/down"
     end

     # Now you can hit http://yourapp.com/ecv and you'll get back either "SYSTEM UP" or "SYSTEM DOWN" depending
     # on whether the :down_file exists
```


### Parameters
down_file - if this file exists, the app is considered to be down (default value => public/system/down)

down_txt - determines the text that will be displayed for the ecv if the app is marked as down (default value: SYSTEM DOWN)

up_txt - determines the text that will be displayed for the ecv if the app is up (default value: SYSTEM UP)



### Hooking it up with init script
You can now have methods in your init script to mark the app as up or down (simply by creating the "down_file" or removing it), and effectively telling the load balancer to direct traffic to your server or not.
