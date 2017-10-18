# Fresh Pots

[![CircleCI](https://img.shields.io/circleci/token/51e5f2f8960c15238f155521f40ad1d9d9808ca5/project/ngscheurich/fresh_pots/master.svg?style=flat-square)](https://circleci.com/gh/ngscheurich/fresh_pots)
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Always know where the fresh coffee’s at.

There are a lot of coffee pots [where I work](http://theadvocate.com), in
different locations spread across multiple floors and buildings. It’s no fun to
venture out to my nearby coffee station only to be greeted by stale, tepid
brew. Furthermore, it seems somehow tragic* to make a fresh pot only to have
its contents languish away into an unpalatable state because you are the only
one aware of its being.

Fresh Pots is a web application that helps to keep teams *au courant* with
their coffee situation by allowing coffee drinkers to easily log when and where
they initiate a brew and to quickly scan the freshness of available pots.

## Table of Contents

* [Install](#install)
* [Overview](#overview)
* [Maintainers](#maintainers)
* [Contribute](#contribute)
* [License](#license)

## Install

You should totally set up Fres hPots for your organization! It requires the
following to be installed:

* Ruby 2.4.x
* PostgreSQL 9.6.x
* Node 6.10.x
* Yarn (or NPM)

After cloning the application and changing to its directory, you’ll want to run
the setup script:

```
% bin/setup
```

This will install application dependencies and create your development
database. Next, initialize your database with:

```
% bin/rails db:migrate
```

That’s all there is to it. Spin up a server on http://localhost:3000 and start
hacking:

```
% bin/rails server
```

## Overview

### Pots

A **pot** represents some physical device with which coffee can be brewed. Pots
have many brews.

```ruby
pot = Pot.first
# => #<Pot id: 1, name: "Break Room", ...>
pot.brews
# => [#<Brew ...>, #<Brew ...>]
```

Authenticated users can get an overview of all of the pots in the application.

### Brews

A **brew** represents an instance of coffee created with a pot. Each brew
belongs to a pot.

```ruby
brew = Brew.first
# => #<Brew id: 1, coffee_type: "Coffee & Chicory", ...>
brew.pot
# => #<Pot ...>
```

Brews will degrade in quality over time, as shown on the application’s main
screen.


## Maintainers

[@ngscheurich](https://github.com/ngscheurich)

## Contribute

PRs accepted.

Small note: If editing the README, please conform to the
[standard-readme](https://github.com/RichardLitt/standard-readme)
specification.

## License

MIT © 2017 N. G. Scheurich
