require "middleman-core"

require "middleman-appcache/version"

::Middleman::Extensions.register(:app_cache) do
  require "middleman-appcache/extension"
  ::Middleman::AppCacheExtension
end
