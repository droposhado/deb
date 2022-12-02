# packages

Packaging for [Go](https://golang.org/) and [Rust](https://www.rust-lang.org/)
binaries, made available for Debian/Ubuntu, without the need to use snap packs.
Especially designed to be compiled and packaged in CI.

Add a `/etc/apt/sources.list.d/droposhado.list` with:

```
deb [trusted=yes] https://deb.droposhado.org/ /
```

Or original url provide by [Gemfury](https://gemfury.com/):

```
deb [trusted=yes] https://apt.fury.io/droposhado/ /
```

## Files

- **\*/setup_\*.sh**: normalizes the build process or ready package download ending with patterns executed by CI;
- **.github/workflows/package.yml** creates the `.deb` packages using [fpm](https://fpm.readthedocs.io/en/latest/) and uploads them to [Gemfury](https://gemfury.com/).

## Contributions

If you want some other binary, you can create an
[issue](https://github.com/droposhado/deb/issues/new) detailing
what you need and as soon as possible i will add or send a PR with support for
the binary you want to be packaged.

## License

see [License](LICENSE)
