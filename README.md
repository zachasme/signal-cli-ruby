# signal-cli

[signal-cli](https://github.com/AsamK/signal-cli), packaged as a gem. You don't need Java or Docker.

This is unofficial packaging. Send bugs in signal-cli itself to [AsamK/signal-cli](https://github.com/AsamK/signal-cli/issues).

## Platforms

Upstream only publishes a native build for x86_64 Linux, so that's the only platform with a bundled binary:

- `x86_64-linux-gnu`: needs glibc 2.34+ and zlib (Debian 12, Ubuntu 22.04 and newer)

Everywhere else, Bundler installs the plain `ruby` gem. Install signal-cli yourself (`brew install signal-cli` on a Mac) and set `SIGNAL_CLI_PATH` to the binary.

## Usage

```ruby
gem "signal-cli"
```

```ruby
SignalCli.executable
# => ".../gems/signal-cli-0.14.9-x86_64-linux-gnu/libexec/signal-cli"
```

The gem also installs a `signal-cli` command:

```
bundle exec signal-cli -a +4512345678 send -m "Hi" +4587654321
```

See upstream's [README](https://github.com/AsamK/signal-cli#usage) for linking and registering an account.

## Versions

The gem version matches upstream's. A 4th part, like `0.14.9.1`, means we fixed the packaging, not signal-cli.

Upstream warns that releases older than 3 months may stop working, so keep the gem up to date. A GitHub Action checks for a new upstream release every day, checks AsamK's signature (`asamk.asc`, the key on [github.com/AsamK.gpg](https://github.com/AsamK.gpg)) and publishes the matching gems.

## License

GPL-3.0, like signal-cli. The source for each bundled binary is upstream's tag with the same version: `https://github.com/AsamK/signal-cli/tree/v<version>`.
