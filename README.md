# LightningcssRails

This gem is adding CSS Compressor class built on https://lightningcss.dev/ library. 

## Installation

As gem using https://lightningcss.dev/ library, you need to install it first. 

```bash
npm install -g lightningcss-cli
```

Then add to ``Gemfile``

```
gem "lightningcss_rails", "~> 0.1.0"
```

## Usage

Within your ``config/environments/production.rb`` set:

```
config.assets.css_compressor = LightningcssRails::Compressor.new
```

Compressor can be used within any other environment, but it is usually not expected. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ShabelnykM/lightningcss_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/lightningcss_rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LightningcssRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lightningcss_rails/blob/master/CODE_OF_CONDUCT.md).
