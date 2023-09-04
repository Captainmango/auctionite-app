# frozen_string_literal: true

Mjml.setup do |config|
  # Use set the templating language for email templates
  config.template_language = :erb

  # Ignore errors silently or not
  config.raise_render_exception = true

  # Optimize the size of your emails
  config.beautify = false
  config.minify = true

  # Render MJML templates with errors
  config.validation_level = 'strict'

  # # Use custom MJML binary with custom version
  # config.mjml_binary = "/path/to/custom/mjml"
  # config.mjml_binary_version_supported = '4.'
end
