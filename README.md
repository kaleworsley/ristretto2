Ristretto - project management and time-tracking
================================================

![Build Status](https://secure.travis-ci.org/kaleworsley/ristretto2.png?branch=master)

Requirements
------------

 - Ruby 1.8.7
 - RubyGems >= 1.3.7
 - Bundler 1.0.14
 - Rails 3.1.0.rc5
 - Rake 0.9.2
 - Git

Setup
-----

 1. Clone Ristretto

    `git clone https://kaleworsley@github.com/kaleworsley/ristretto2.git`

 2. Change to directory

    `cd ristretto2`

 3. Install dependencies

    `bundle install`

 4. Setup config and database yaml files

    `rake ristretto:setup`

 5. Setup database

    `rake db:setup`

 6. Start rails server

    `rails server`

License
-------

Ristretto is released under the GNU Affero General Public License.

