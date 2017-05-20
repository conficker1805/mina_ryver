require 'json'

def _slack_api_token
  fetch(:slack_api_token, '')
end

def _slack_channels
  fetch(:slack_channels, [])
end

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

def _slack_text_at_start
  fetch(:slack_text_at_start, "Start deploying branch \\\`#{_branch}\\\` to \\\`#{_slack_application}\\\`.")
end

def _slack_text_at_finished
  text = fetch(:slack_text_at_finished, "Finished deploying branch \\\`#{_branch}\\\` to \\\`#{_slack_application}\\\`.")
  text += " See it here: #{_slack_domain}" if _slack_domain != nil
  text
end

set :slack_link_names, 1

def _slack_parse
  fetch(:slack_parse, 'full')
end

def _slack_icon_url
  fetch(:slack_icon_url, '')
end

def _slack_icon_emoji
  fetch(:slack_icon_emoji, ':slack:')
end

def _slack_domain
  fetch(:slack_domain, nil)
end

namespace :slack do
  # ## slack:notify_deploy_started
  desc "Send slack notification about new deploy start"
  task :notify_deploy_started => :environment do
    command  %[echo "-----> Sending start notification to Slack"]

    for channel in _slack_channels
      send_message(
        channel: channel,
        text:    _slack_text_at_start
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
        text:        _slack_text_at_finished,
        attachments: _slack_attachments
      )
    end
  end

  def send_message(params = {})
    command %[curl -X POST https://slack.com/api/chat.postMessage -d "token=#{_slack_api_token}&channel=#{params[:channel]}&username=#{_slack_username}&text=#{params[:text]}&attachments=params[:attachments]&parse=#{_slack_parse}&link_names=#{_link_names}&icon_url=#{_slack_icon_url}&icon_emoji=#{_slack_icon_emoji}" --silent > /dev/null]
  end

end
