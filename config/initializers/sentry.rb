# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://2edf40881af3424acd0bf1d9b9543287@o4508749332283392.ingest.de.sentry.io/4508749335363664'

  # get breadcrumbs from logs
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # enable tracing
  # we recommend adjusting this value in production
  config.traces_sample_rate = 1.0

  # enable profiling
  # this is relative to traces_sample_rate
  config.profiles_sample_rate = 1.0
end
