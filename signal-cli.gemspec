# frozen_string_literal: true

require_relative "lib/signal-cli"

Gem::Specification.new do |spec|
  spec.name = "signal-cli"
  spec.version = SignalCli::VERSION
  spec.authors = [ "Zacharias Knudsen" ]
  spec.email = [ "z@chari.as" ]

  spec.summary = "A self-contained signal-cli executable."
  spec.description = "Unofficial packaging of AsamK/signal-cli's native build, so a Ruby app can send and receive Signal messages without Java or Docker."
  spec.homepage = "https://github.com/zachasme/signal-cli-ruby"
  spec.license = "GPL-3.0-only"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = %w[ lib/signal-cli.rb exe/signal-cli LICENSE README.md ]
  spec.bindir = "exe"
  spec.executables = [ "signal-cli" ]
end
