This is the developer documentation web site for BigBlueButton.

This site uses Jekyll to build the documentation site.  You can setup Jekyll to build the website locally so you can preview the site before pushing changes.

### The easy way

The easy to generate the BigBlueButton documentation locally and see the effect of your changes before committing is to create a Docker image that runs Jekyll.  If you have installed Docker, then create a `Dockerfile` using the following text

```
FROM ubuntu:16.04
MAINTAINER Fred Dixon

RUN apt-get update
RUN apt-get -y install build-essential zlib1g-dev ruby-dev ruby nodejs vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN gem install github-pages bundler therubyracer

VOLUME /site

EXPOSE 4000

WORKDIR /site
ENTRYPOINT ["jekyll"]
```
and then build it with the command

    docker build -t github-pages .

This creates a self-contained jekyll server for serving GitHub pages.  After the images builds, then if, for example, you've checked out this repository to `/Users/ffdixon/fred/bigbluebutton.github.io`, you can render it locally using the command

    docker run --rm -v /Users/ffdixon/fred/bigbluebutton.github.io:/site -p 4000:4000 github-pages serve --watch --host 0.0.0.0
 
When you run this command you'll see

```
$ docker run --rm -v /Users/ffdixon/fred/bigbluebutton.github.io:/site -p 4000:4000 github-pages serve --watch --host 0.0.0.0
Configuration file: /site/_config.yml
Configuration file: /site/_config.yml
            Source: /site
       Destination: /site/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
                    done in 8.521 seconds.
 Auto-regeneration: enabled for '/site'
Configuration file: /site/_config.yml
    Server address: http://0.0.0.0:4000/
  Server running... press ctrl-c to stop.
```
And you can now view the site using the URL http://localhost:4000/.  If the Docker approach does not work, you can setup Jekyll using the steps below.
   
### Ruby

To install Ruby, we suggest the use of [rbenv](https://github.com/rbenv/rbenv).

But you have other options:

* Using RVM: see [this page](https://rvm.io/rvm/install/).
* Using apt packages.
* From source.

From now on, we will assume you will use rbenv, so if you decide for another method you might have to adapt some of commands in the rest of this guide.

The commands below will show you how to install rbenv. In short, this is what you will be doing:

* Install rbenv
* Install the plugin [ruby-build plugin](https://github.com/rbenv/ruby-build), that will actually be used to install ruby
* Install the target ruby
* Install bundler

**Important: if you have RVM installed, you should remove it first!**

```bash
# Install rbenv
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
$ source ~/.bash_profile

# install ruby build
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# clone this repo
$ git clone https://github.com/bigbluebutton/bigbluebutton.github.io.git

# install the targeted version of ruby
$ cd bigbluebutton.github.io
$ rbenv install
$ rbenv rehash
$ rbenv version
> 2.2.1 (set by (...)/bigbluebutton.github.io/.ruby-version)

# install bundler
$ gem install bundler
$ rbenv rehash
```

### Jekyll

At this point you have the correct version of Ruby installed, now you have to install the site dependencies. Enter the directory bigbluebutton.github.io and type

 ```
 bundle install
 ```

 This will install all the Jekyll components.  Next, type

 ```
 jekyll serve --host=0.0.0.0
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
