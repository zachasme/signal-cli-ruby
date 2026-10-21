# frozen_string_literal: true

require "rake/clean"
require "rake/testtask"
require "rubygems/package_task"
require_relative "lib/signal-cli"

# `rake package` builds 2 gems into pkg/:
#
# - signal-cli-<version>.gem, which finds signal-cli through SIGNAL_CLI_PATH
# - signal-cli-<version>-x86_64-linux-gnu.gem, which bundles upstream's native build
#
# The native build is downloaded once into tmp/ and only kept if AsamK's signature checks out.

version = SignalCli::UPSTREAM_VERSION
tarball = "tmp/signal-cli-#{version}-Linux-native.tar.gz"
binary = "libexec/signal-cli"

gemspec = Gem::Specification.load("signal-cli.gemspec")
Gem::PackageTask.new(gemspec).define
Gem::PackageTask.new(gemspec.dup.tap { |spec| spec.platform = "x86_64-linux-gnu"; spec.files += [ binary ] }).define

file tarball do
  mkdir_p "tmp"
  url = "https://github.com/AsamK/signal-cli/releases/download/v#{version}/#{File.basename(tarball)}"
  sh "curl", "-fsSL", "-o", "#{tarball}.download", url
  sh "curl", "-fsSL", "-o", "#{tarball}.asc", "#{url}.asc"
  sh "gpg --dearmor < asamk.asc > tmp/asamk.gpg"
  sh "gpgv", "--keyring", "./tmp/asamk.gpg", "#{tarball}.asc", "#{tarball}.download"
  mv "#{tarball}.download", tarball
end

file binary => tarball do
  mkdir_p "libexec"
  sh "tar", "-xzmf", tarball, "-C", "libexec", "signal-cli"
end

Rake::TestTask.new { |t| t.pattern = "test/**/*_test.rb" }

desc "Check that the bundled binary runs and is the expected version"
task smoke: binary do
  output = `#{FileUtils::RUBY} -Ilib exe/signal-cli --version`.strip
  abort "Expected signal-cli #{version}, got #{output.inspect}" unless output == "signal-cli #{version}"
  puts output
end

task default: %i[ test smoke ]

CLOBBER.include("libexec", "tmp")
