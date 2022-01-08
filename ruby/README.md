Redis in Action (Ruby code samples)
===================================

### System Setup

**NOTE:** Tested on Mac OS X 12.1, Ruby 2.4.2, Redis 6.2.6

Install the latest stable version of Ruby (2.4.2) via rvm or rbenv

```
rvm install 2.4.2
rvm use 2.4.2
gem install bundler
```

Install the latest stable version of Redis via Homebrew

```
brew install redis
```

Clone the code base and install pre-requisite gems.
NOTE: my `bundle install` failed and I had to run `bundle update rb-inotify` before bundling again.

```
git clone git@github.com:josiahcarlson/redis-in-action.git
cd redis-in-action/ruby
bundle install
```

---

To run a specific test suite:

```
bundle exec rspec spec/chapter01_spec.rb
```

Alternatively, you can launch `guard`, it will "auto-runs" your tests when files
are modified.

```
bundle exec guard
```

### Appendix A.4

```
gem install redis
```

```
~:$ irb
2.4.2 :001 > require 'redis'
 => true
2.4.2 :002 > conn = Redis.new
 => #<Redis client v3.3.1 for redis://127.0.0.1:6379/0>
2.4.2 :003 > conn.set('hello','world')
 => "OK"
2.4.2 :004 > conn.get('hello')
 => "world"
```
