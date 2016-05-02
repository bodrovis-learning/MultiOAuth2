# README

Application demonstrating how to implement scenario with a user having multiple
social accounts and an ability to connect/disconnect them.

To boot this app:

* Create *config/local_env.yml* file with the following contents:

```yaml
TWITTER_KEY: ''
```

* `bundle install`
* `rails db:migrate`
* `rails s`
* Navigate to [127.0.0.1:3000](http://127.0.0.1:3000)
* Have fun

To add a new social provider:

* Simply modify *config/initializers/omniauth.rb* file
* ...that's pretty much it

(c) 2016 [Ilya Bodrov](http://radiant-wind.com)