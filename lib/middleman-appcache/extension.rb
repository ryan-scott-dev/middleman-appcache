
module Middleman

  class AppCacheExtension < Middleman::Extension

    option :cache_manifest, 'manifest.appcache', 'The name of the generated cache manifest'

    option :cache, ['index.html'], 'List of directories or files that will be cached.'
    option :network, ['*'], 'Resources that require the user to be online.'
    option :fallback, {}, 'Fallback resources if a resource is unavailable.'
    option :use_relative, true, 'If the cached files should be generated as relative paths.'
    option :version_hash, true, 'If the contents of the files should be hashed and added as a comment.'

    def initialize app, options_hash = {}, &block
      super

      cache_manifest_filename = options.cache_manifest
      cache_options = options.cache
      network_options = options.network
      fallback_options = options.fallback
      use_relative = options.use_relative
      version_hash = options.version_hash

      if version_hash
        require 'digest'
        hash = Digest::MD5.new
      end

      app.after_build do |builder|
        cache = []

        cache_options.each do |cache_file_pattern|
          directory = File.join(config[:build_dir], cache_file_pattern)
          files_to_cache = Dir.glob(directory)
          files_to_cache.each do |file_to_cache|
            build_dir = config[:build_dir]
            build_dir = "#{build_dir}/" if use_relative
            cache << file_to_cache.gsub(build_dir, '')
            if version_hash
              hash.file file_to_cache if File.file? file_to_cache
            end
          end
        end

        manifest_file = File.join(config[:build_dir], cache_manifest_filename)
        File.open(manifest_file, "w") do |f|
          f.write "CACHE MANIFEST\n\n"

          if version_hash
            f.write "\# version #{hash.hexdigest}\n\n"
          end

          f.write "CACHE:\n"
          cache.each do |cache_file|
            f.write "#{cache_file}\n"
          end
          f.write "\n"

          if network_options.any?
            f.write "NETWORK:\n"
            network_options.each do |network_url|
              f.write "#{network_url}\n"
            end
            f.write "\n"
          end

          if fallback_options.any?
            f.write "FALLBACK:\n"
            fallback_options.each do |url, fallback_resource|
              f.write "#{url} #{fallback_resource}\n"
            end
            f.write "\n"
          end
        end

        builder.say_status :regenerated, cache_manifest_filename
      end
    end

  end
end
