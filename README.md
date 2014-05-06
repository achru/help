# Help me!

[![Code Climate](https://codeclimate.com/github/netguru/help.png)](https://codeclimate.com/github/netguru/help)
[![Dependencies](http://allthebadges.io/netguru/help/gemnasium.png)](http://allthebadges.io/netguru/help/gemnasium)

![Circle CI](https://circleci.com/gh/netguru/help/tree/master.png?circle-token=0b87a42d881a82d69dca72d9c0f4cc680f795f62)

This application is a simple, easy to run support system for your team. It's ment to be used internally, to encourage your team members to help each other.

The flow is quite simple:

* we sign in users with google apps
* every user selects the topics, he feels he can help with
* user seeking for help picks the topic from the list and application will randomly assign somebody to help him (from the list of users that marked the topic as their skill)

TL;DR: you select what you can help with or application selects somebody to help you

## Deploying
This is just a simple rails app, can be easly deployed to heroku under < 5 time mark :)
Once you have your heroku.com account set up, do this:

* Clone the application locally:

  `git clone git://github.com/netguru/help.git help-app && cd help-app`

* create an empty app on heroku, with postgres - replace 'crazysheeps' with your own app name:

  `heroku apps:create crazysheeps --addons heroku-postgresql`

* push the app to heroku, let them do their thing:

  `git push heroku`

* load the database schema

  `heroku run rake db:schema:load`

## Configuration

### Setup database

create user and a role, then copy sample `database.yml` file.

```shell
createuser --superuser --createrole help
cp config/database.yml.sample config/database.yml
```

Once it's deployed it needs few configuration variables to run properly.
Here is the config file for reference: [https://github.com/netguru/help/blob/master/config/config.yml#L18](https://github.com/netguru/help/blob/master/config/config.yml#L18)

* Secret key base - used for encrypting cookies

  `heroku config:set SECRET_KEY_BASE=randomstringwithminimum30characters`

* App domain - the domain the application is aviable under. Like so:

  `heroku config:set APP_DOMAIN=crazysheeps.herokuapp.com`

* Google apps - we assume you use google ouath for authentication.
Go to your [google console](https://cloud.google.com/console/project) to generate oauth client and secret for the project.
In google console set `your_help_app_domain.com/auth/google_oauth2/callback`

* You can use plain google account but we recommend using google apps, to scope login to emails from your organization.
Set values like so:

  ```shell
  heroku config:set GAPPS_ID=google_apps_client_id
  heroku config:set GAPPS_SECRET=google_apps_client_secret
  heroku config:set GAPPS_DOMAIN=google_apps_primary_domain
  ```

* Postmark - if you want the application to send out email notifications on support request you can configure it to use postmark free account. Heroku makes it easy - read more here and follow the instructions: [https://addons.heroku.com/postmark#10k](https://addons.heroku.com/postmark#10k)

  ```shell
  heroku addons:add postmark
  heroku config:set POSTMARK_API_KEY=the_api_token_from_postmark_account
  ```

  Once you do have your postmark account connected with heroku, you can configure a from address with them (or set it to postmark default).
  More here: [http://support.postmarkapp.com/customer/portal/articles/64741-how-can-i-send-on-behalf-of-my-users-](http://support.postmarkapp.com/customer/portal/articles/64741-how-can-i-send-on-behalf-of-my-users-)

  `heroku config:set POSTMARK_FROM=the_address_you_selected@example.com`

* You can also set a cc address for all support emails to scope the conversations under google group, or add notifications with [Zappier](https://zapier.com/zapbook/email/) - we used this to display support activity on hipchat: [https://zapier.com/zapbook/email/hipchat/](https://zapier.com/zapbook/email/hipchat/)

  `heroku config:set DEFAULT_CC=default_cc_address@example.com`

* HipChat notifications - if you want the application to send notifications on hipchat on support request, set up your token and you are ready to go

  ```shell
  heroku config:set HIPCHAT_TOKEN=token
  heroku config:set HIPCHAT_ROOM=room
  ```
  
  if you don't want to use hipchat notifications, you can disable it in ```config/initializers/hipchat_notifications.rb```

## Setting help subjects

For now we did not yet develop any admin panel for the application. You will have to use heroku console to create your support categories. This is how we set them:

```ruby
> heroku run rails console

irb(main):001:0> Topic.create(title: 'test category')
=> #<Topic id: 3, title: "test category">
irb(main):002:0> Topic.create(title: 'anoter help subject')
=> #<Topic id: 4, title: "anoter help subject">
```

## Read more

Read more about the app & story behind at [Open Source App To Support Your Culture](https://netguru.co/blog/posts/open-source-app-to-support-your-culture).

Copyright (c) 2014 [Netguru](https://netguru.co). See LICENSE for further details.
