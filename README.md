# Middleman Application Cache

> Generate a [Application Cache Manifest](https://developer.mozilla.org/en-US/docs/Web/HTML/Using_the_application_cache) to support offline access.

## Disclaimer

I have developed this for the intention of using it exclusively for single page applications.

While it **can** be extended to support App Cache Manifests for multiple pages, I have no intent at this point in time to develop support for this.

If it is something that you do need, please let me know and I'll investigate how it could work without compromising the configuration syntax.

## Usage

Add the following line to `Gemfile`, then run `bundle install`:

```ruby
gem 'middleman-appcache'
```

Add a link to the appcache name in you html layout:

```html
<html manifest="manifest.appcache">
  ...
</html>
```

And active the extension inside config.rb:

```ruby
activate :app_cache do |config|
  config.cache_manifest = 'manifest.appcache'
  config.cache = %w(index.html favicon.ico stylesheets/*.css javascripts/*.js images/*)
end
```

Then when you run `middleman build`, the application cache will be generated in the build directory.

## Configuration

The extension has 5 optionally configurable fields:

```ruby
activate :app_cache do |config|
  config.cache_manifest = 'manifest.appcache'
  config.cache = %w(index.html offline.html favicon.ico stylesheets/*.css javascripts/*.js images/*)
  config.network = %w(/ /login /logout)
  config.fallback = {
    '/' => 'offline.html'
  }
  config.use_relative = false
  config.version_hash = true
end
```

The above configuration will generate the following appcache:

```manifest.appcache
CACHE MANIFEST

# version 1aadc03fe3f695a96d64f1a190b6253e

CACHE:
/index.html
/offline.html
/favicon.ico
/stylesheets/all-3676b7b2.css
/stylesheets/normalize-6197e73d.css
/javascripts/all-24162989.js
/javascripts/vendor-e28aee79.js
/images/welcome-64a62e79.png

NETWORK:
/
/login
/logout

FALLBACK:
/ /offline.html

```

### cachemanifest

The filename for the generate cache manifest. 

**Default:** `'manifest.appcache'`

### cache

The list of files, directories, or glob patterns which should be cached.

**Default:** `['index.html']` 

### cache

The list of files, directories, or glob patterns which should be cached.

**Default:** `['index.html']` 

### network

The list of resources that require the user to be online.

**Default:** `['*']`

### fallback

The mapping of fallback resources if a resource is unavailable.

**Default:** `Empty`

### use_relative

If the resources should be treated as relative from the appcache.

**Default:** `true`

### version_hash

If a version hash should be generated from the contents of the referenced files.

**Default:** `true`

## License

Middleman Application Cache was created by [Ryan Scott](http://github.com/archytaus) is distributed under the [MIT](http://ryanscott.mit-license.org) license.
