# Fresh Pots

<p align="center">
  <img src="public/logo.png" alt="RouteMate logo" width="100" height="101">
</p>

<p align="center">
  Always know where the fresh coffee’s at.
</p>

<p align="center">
  <a href="https://circleci.com/gh/ngscheurich/fresh_pots">
    <img src="https://circleci.com/gh/ngscheurich/fresh-pots.svg?style=shield" alt="Build badge" />
    </a>
  
  <a href="https://codeclimate.com/github/ngscheurich/fresh-pots/test_coverage">
    <img src="https://api.codeclimate.com/v1/badges/96cec22aeadc92ee0f02/test_coverage" alt="Coverage badge" />
  </a>
  
  <a href="https://codeclimate.com/github/ngscheurich/fresh-pots/maintainability">
    <img src="https://api.codeclimate.com/v1/badges/96cec22aeadc92ee0f02/maintainability" alt="Maintainability badge" />
  </a>
  
  <a href="https://github.com/RichardLitt/standard-readme">
    <img src="https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat" alt="standard-readme compliance badge" />
  </a>
</p>


There are a lot of coffee pots [where I work](http://theadvocate.com), in
different locations spread across multiple floors and buildings. It’s no fun to
venture out to your nearby coffee station only to be greeted by a stale, tepid
brew. Furthermore, it seems wasteful to make a fresh pot only to have
its contents languish away because no one but you is aware of it.

Fresh Pots is a web application that helps to keep teams *au courant* with
their coffee situation by allowing coffee drinkers to easily log when and where
they start a brew and to quickly scan the freshness of available pots.

Currently, Fresh Pots is available at [https://www.freshpots.com](https://www.freshpots.com) and
as [an iOS app](https://github.com/ngscheurich/fresh-pots-ios).

The name *Fresh Pots* does have [an origin](https://youtu.be/fhdCslFcKFU), in case you were wondering.

## Table of Contents

* [Install](#install)
* [Domain Model](#domain-model)
* [Maintainers](#maintainers)
* [Contribute](#contribute)
* [License](#license)

## Install

You should totally set up Fresh Pots for your organization! I originally intended for this project
to be fully decoupled from my place of employment, but time constraints. I’d be glad to
accept any PRs that make the project more easily usable for any team.

After cloning the project and changing to its directory, you’ll want to run
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

### Dependencies

Fresh Pots requires the following to be installed:

* Ruby 2.4.x
* PostgreSQL 9.6.x
* Node 6.10.x
* Yarn (or NPM)

## Domain Model

<img src="https://i.imgur.com/FWpnroj.gif" alt="Dave Grohl exclaiming 'fresh pots!'" width="100%" />

### Users

A **user** is someone that authenticates with the app and then creates brews and marks
pots as empty. Users have many brews.

### Pots

A **pot** represents some physical device with which coffee can be brewed. If it makes
more sense for your situation, you can think of a pot as a location, e.g., *break room*.
Either way, pots have many brews.

```ruby
pot = Pot.first
# => #<Pot id: 1, name: "Nick’s Chemex", ...>
pot.brews
# => [#<Brew ...>, #<Brew ...>]
```

### Varieties

A **variety** represents a particular blend or style of coffee. Think *Dark Roast*,
*Kenyan Single Origin*, or
[*Hombre Cohete*](https://cafeciteaux.com/product/hombre-cohete-rocket-man/).

```ruby
Variety.first
# => #<Variety id: 1, name: "Community Coffee & Chicory", ...>
```

### Brews

A **brew** represents an instance of some variety of coffee created with a pot. Each brew
belongs to a pot, a variety, and a user.

```ruby
brew = Brew.first
# => #<Brew id: 1 ...>
brew.pot
# => #<Pot ...>
brew.variety
# => #<Variety ...>
brew.user
# => #<User ...>
```

Brews will degrade in freshness over time, as shown on the application dashboard.

## Maintainers

[@ngscheurich](https://github.com/ngscheurich)

## Contribute

PRs accepted.

Small note: If editing the README, please conform to the
[standard-readme](https://github.com/RichardLitt/standard-readme)
specification.

## License

MIT © 2018 N. G. Scheurich
