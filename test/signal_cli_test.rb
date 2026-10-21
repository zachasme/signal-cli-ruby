# frozen_string_literal: true

require "minitest/autorun"
require "signal-cli"

class SignalCliTest < Minitest::Test
  def teardown
    ENV.delete("SIGNAL_CLI_PATH")
  end

  def test_uses_signal_cli_path_when_set
    ENV["SIGNAL_CLI_PATH"] = FileUtils::RUBY
    assert_equal FileUtils::RUBY, SignalCli.executable
  end

  def test_explains_what_to_do_when_the_binary_is_missing
    ENV["SIGNAL_CLI_PATH"] = "/nonexistent/signal-cli"
    error = assert_raises(SignalCli::ExecutableNotFound) { SignalCli.executable }
    assert_includes error.message, "Cannot find signal-cli at /nonexistent/signal-cli"
  end
end
