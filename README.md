## Installation

Add this line to your application's Gemfile:

    gem 'mina_ryver'
    
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina_ryver


## Usage

### Load the recipe
Include the recipe in your deploy.rb

    # config/deploy.rb
    require 'mina_ryver/tasks'
    
### Setup Ryver Details
You'll need to create a hook to push message to your channel. You should use ENV variable for this. 
The url should be like this: https://your-domain.ryver.com/application/webhook/2JHY77a4Bg4An9X

    # required
    set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
    set :ryver_channels, ['2JHY77a4Bg4An9X']
    set :ryver_application, 'production-server'
    
    task :deploy do
      deploy do
        invoke :'ryver:notify_deploy_started'
        ...

        to :launch do
          ...
          invoke :'ryver:notify_deploy_finished'
        end
      end
    end
    
This will push a message to your ryver application: "Start deploying branch [current_branch] to [ryver_application]" and "Finished deploying branch [current_branch] to [ryver_application]"
