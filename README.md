# Jekyll Docker Images

Jekyll Docker is a full featured Alpine based Docker image that provides an isolated Jekyll instance with the latest version of Jekyll and a bunch of nice stuff to make your life easier when working with Jekyll in both production and development.  For documentation please visit the wiki at https://github.com/jekyll/docker/wiki where you will find docs and sometimes examples.

This project is a fork that adds support for `jekyll liveserve` and a few extra default gems:

* git
* hawkins
* octopress-minify-html
* nokogiri

## Running

[![](https://images.microbadger.com/badges/image/spyder/jekyll.svg)](https://microbadger.com/images/spyder/jekyll)

`docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 -p 127.0.0.1:35729:35729 spyder/jekyll bundle exec jekyll liveserve`

Add the following to your shell profile and you can run `jekyll liveserve` or `jekyll build` etc to run via docker:

```
alias jekyll='rm -f Gemfile.lock && docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 -p 127.0.0.1:35729:35729 spyder/jekyll bundle exec jekyll'
```

## Common issues

If you upgrade the docker image, make sure to delete your `Gemfile.lock` as older gem versions are not maintained. With an older lock file those versions will attempt to install and probably fail.

## Building

There are two options for building; direct, as in the parent repo, or using my custom docker image. The `Dockerfile` to create this custom docker image is in the root directory of this repository.

Direct instructions:
> You can build our images or any specific tag of an image with `bundle exec docker-template build` or `bundle exec docker-template build repo:tag`, yes it's that simple to build our images even if it looks complicated it's not.

If you're like me and don't want to install the ruby dependencies, use my docker image to build the jekyll images. Run this command:

[![](https://images.microbadger.com/badges/image/spyder/jekyllbuild.svg)](https://microbadger.com/images/spyder/jekyllbuild)

`docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/build spyder/jekyllbuild bundle exec docker-template build jekyll:latest`

The docker socket redirect is linux/mac specific, I'm not sure how to do that on windows. Google may be able to tell you.

Everything after `build` is the same as in the parent repo, so you can change or remove the `jekyll:latest` tag.

### Note to self

After building the image, use `docker tag jekyll/jekyll spyder/jekyll` to create my alias.
