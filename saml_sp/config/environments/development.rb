Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # action_mailer
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false

  # active_record
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  # active_storage
  config.active_storage.service = :local

  # active_support
  config.active_support.deprecation = :log

  # assets
  config.assets.debug = true
  config.assets.quiet = true

  # file_watcher
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
