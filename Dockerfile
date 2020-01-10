FROM ubuntu:18.04
MAINTAINER Fred Dixon

RUN apt-get update
RUN apt-get -y install build-essential zlib1g-dev ruby-dev ruby nodejs vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN gem install tzinfo libv8 github-pages bundler therubyracer

VOLUME /site

EXPOSE 4000

WORKDIR /site
ENTRYPOINT ["jekyll"]
