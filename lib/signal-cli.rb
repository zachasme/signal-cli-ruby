# frozen_string_literal: true

module SignalCli
  # The upstream signal-cli version, plus an optional 4th part for repackaging fixes.
  VERSION = "0.14.9"
  UPSTREAM_VERSION = VERSION[/\A\d+\.\d+\.\d+/]

  # The x86_64-linux-gnu gem bundles upstream's native build here. The ruby gem doesn't.
  BUNDLED = File.expand_path("../libexec/signal-cli", __dir__)

  class ExecutableNotFound < StandardError; end

  def self.executable
    path = ENV["SIGNAL_CLI_PATH"].to_s.empty? ? BUNDLED : ENV["SIGNAL_CLI_PATH"]
    return path if File.file?(path) && File.executable?(path)

    raise ExecutableNotFound, <<~MESSAGE
      Cannot find signal-cli at #{path}.

      This gem bundles upstream's native build for x86_64 Linux (glibc 2.34+) only.
      On that platform, make sure Bundler installs the native gem:

          bundle lock --add-platform x86_64-linux-gnu

      Anywhere else, install signal-cli yourself and set SIGNAL_CLI_PATH to the binary.
    MESSAGE
  end
end
