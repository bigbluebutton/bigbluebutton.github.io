This is the developer documentation web site for BigBlueButton.

This site uses Jekyll to build the documentation site.  You can setup Jekyll to build the website locally so you can preview the site before pushing changes.

On a Ubuntu 14.0.4 machine, install ruby 2.2.1 following the instructions at https://gorails.com/setup/ubuntu/14.04

To setup Jekyll, you need to have ruby and the bundler gem installed.  Once setup, enter the directory bigbluebutton.github.io and type

 ```
 bundle install
 ```

 This will install all the Jekyll components.  Next, type

 ```
 jekyll serve
 ```

Jekyll will run a server on port 4000 that lets you see a live update of the site after you make a save of any file.

 ```
 Freds-Air:bigbluebutton.github.io ffdixon$ jekyll serve
Configuration file: /Users/ffdixon/bigbluebutton.github.io/_config.yml
            Source: /Users/ffdixon/bigbluebutton.github.io
       Destination: /Users/ffdixon/bigbluebutton.github.io/_site
      Generating... 
                    done.
 Auto-regeneration: enabled for '/Users/ffdixon/bigbluebutton.github.io'
Configuration file: /Users/ffdixon/bigbluebutton.github.io/_config.yml
    Server address: http://0.0.0.0:4000/
  Server running... press ctrl-c to stop.
```

You can now edit files locally, review changes locally, and push commits to GitHub.
