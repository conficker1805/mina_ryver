require 'json'

def _ryver_channels
  fetch(:ryver_channels, [])
end

def _branch
  fetch(:branch, "")
end

def _ryver_application
  fetch(:ryver_application, "")
end

def _ryver_text_at_start
  fetch(:ryver_text_at_start, "Start deploying branch \\\`#{_branch}\\\` to \\\`#{_ryver_application}\\\`.")
end

def _ryver_text_at_finished
  text = fetch(:ryver_text_at_finished, "Finished deploying branch \\\`#{_branch}\\\` to \\\`#{_ryver_application}\\\`.")
  text += " See it here: #{_ryver_domain}" if _ryver_domain != nil
  text
end

def _ryver_domain
  fetch(:ryver_domain, nil)
end

namespace :ryver do
  # ## ryver:notify_deploy_started
  desc "Send ryver notification about new deploy start"
  task :notify_deploy_started => :environment do
    command  %[echo "-----> Sending start notification to Ryver"]

    _ryver_channels.each do |channel|
      send_msg(channel, _ryver_text_at_start)
    end
  end

  # ## ryver:notify_deploy_finished
  desc "Send ryver notification about deploy finish"
  task :notify_deploy_finished => :environment do
    command  %[echo "-----> Sending finish notification to Ryver"]

    _ryver_channels.each do |channel|
      send_msg(channel, _ryver_text_at_finished)
    end
  end

  def send_msg(channel, message)
    command %[curl -X "POST" "https://scry.ryver.com/application/webhook/#{channel}" -H "Content-Type: text/plain; charset=utf-8" -d "#{message}"]
  end
end
