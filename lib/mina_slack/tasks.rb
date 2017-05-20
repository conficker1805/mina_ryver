require 'json'

# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### slack_api_token
# Sets the slack api auth token.
def _slack_api_token
  fetch(:slack_api_token, '')
end

# ### slack_channels
# Sets the channels where notifications will be sent to.
def _slack_channels
  fetch(:slack_channels, [])
end

# ### slack_username
# Sets the notification 'from' user label
def _slack_username
  fetch(:slack_username, 'Deploy username')
end

def _slack_attachments
  fetch(:slack_attachments, '[{"fields": [{"value": "Value"}]}]')
end

def _link_names
  fetch(:link_names)
end

def _branch
  fetch(:branch, "")
end

def _slack_application
  fetch(:slack_application, "")
end

def _text_at_start
  fetch(:text_at_start, "Start deploying branch #{_branch} to #{_slack_application}")
end

def _text_at_finished
  text = fetch(:text_at_finished, "Finished deploying branch #{_branch} to #{_slack_application}")
  text += " See it here: #{_slack_domain}" if _slack_domain != nil
  text
end

# ### slack_link_names
# Sets the deployment author name
set :slack_link_names, 1

# ### slack_parse
# Sets the deployment author name
def _slack_parse
  fetch(:slack_parse, 'full')
end

# ### icon_url
# URL to an image to use as the icon for this message
def _slack_icon_url
  fetch(:slack_icon_url, '')
end

# ### icon_emoji
# Sets emoji to use as the icon for this message. Overrides `slack_icon_url`
def _slack_icon_emoji
  fetch(:slack_icon_emoji, ':slack:')
end

def _slack_domain
  fetch(:slack_domain, nil)
end

# ## Control Tasks
namespace :slack do

  # ## slack:notify_deploy_started
  desc "Send slack notification about new deploy start"
  task :notify_deploy_started => :environment do
    command  %[echo "-----> Sending start notification to Slack"]

    for channel in _slack_channels
      send_message(
        channel: channel,
        text:    _text_at_start
      )
    end
  end

  # ## slack:notify_deploy_finished
  desc "Send slack notification about deploy finish"
  task :notify_deploy_finished => :environment do
    command  %[echo "-----> Sending finish notification to Slack"]

    for channel in _slack_channels
      send_message(
        channel:     channel,
        text:        _text_at_finished,
        attachments: _slack_attachments
      )
    end
  end

  def send_message(params = {})
    command %[curl -X POST https://slack.com/api/chat.postMessage -d "token=#{_slack_api_token}&channel=#{params[:channel]}&username=#{_slack_username}&text=#{params[:text]}&attachments=params[:attachments]&parse=#{_slack_parse}&link_names=#{_link_names}&icon_url=#{_slack_icon_url}&icon_emoji=#{_slack_icon_emoji}" --silent > /dev/null]
  end

end
