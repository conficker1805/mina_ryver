mina_slack <a href="http://badge.fury.io/rb/mina_slack"><img src="https://badge.fury.io/rb/mina_slack.svg" alt="Gem Version" height="18"></a>
============

mina_slack is a gem that adds tasks for sending notifications to [Slack] (http://slack.com)
using [Mina] (http://nadarei.co/mina).

## Create API token

    Following below link to create API token
    https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens

## Installation

    gem install mina_slack

## Usage example

    require 'mina_slack/tasks'
    ...
    # Required mina_slack options
    set :slack_api_token, 'xxxyyyzzz'
    set :slack_channels, ['#general', '@mbajur', '#nerd']

    task :deploy do
      deploy do
        invoke :'slack:notify_deploy_started'
        ...

        to :launch do
          ...
          invoke :'slack:notify_deploy_finished'
        end
      end
    end

## Available Tasks

* `slack:notify_deploy_started`
* `slack:notify_deploy_finished`

## Available Options

| Option                    | Description                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------ |
| __slack_api_token__       | API auth token.                                                                      |
| __slack_channels__        | Array of channels (or users) where notifications will be sent to.                    |
| slack_username            | Name of bot. <br> _default: Deploy_ username                                         |
| slack_link_names          | Find and link channel names and usernames. <br> _default: 1_                         |
| slack_parse               | Change how messages are treated. [Read more] (https://api.slack.com/docs/formatting) <br> _default: full_ |
| slack_icon_url            | URL to an image to use as the icon for this message <br> _default: nil_ |
| slack_icon_emoji          | emoji to use as the icon for this message. Overrides `slack_icon_url`. <br> _default: :slack:_ |
| slack_application         | Application name for the case that you have multiple servers                       |
| slack_domain              | Domain name of the server                                                          |
| slack_text_at_start       | The text that is sent to slack at beginning of deployment                          |
|                             Default: Start deploying branch {branch} to {slack_application}                    |
| slack_text_at_finished    | The text that is sent to slack at completion of deployment                         |
|                             Default: Finished deploying branch {branch} to {slack_application}. See it here: {slack_domain} |

__* required options__

## Todo

* Write some tests

## Copyright

Copyright (c) 2014 Mike Bajur http://github.com/mbajur

See LICENSE for further details.
