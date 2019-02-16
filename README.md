## Installation

Add this line to your application's Gemfile:

    gem 'mina-ryver'
    
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-ryver


## Usage

### Load the recipe
Include the recipe in your deploy.rb

    # config/deploy.rb
    require 'mina/slack'
    
### Setup Ryver Details
You'll need to create a hook to push message to your channel. You should use ENV variable for this. 
The url should be like this: https://scry.ryver.com/application/webhook/2JHY77a4Bg4An9X

    # required
    set :ryver_channels, ['2JHY77a4Bg4An9X']
    
    ```
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
    ```
