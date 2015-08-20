# StringsXmlLocalizer [<img src="https://travis-ci.org/hoangphanea/strings_xml_localizer.svg" alt="Build Status" />](https://travis-ci.org/hoangphanea/strings_xml_localizer)

A very simple gem to translate contents of a strings.xml file from one locale to another. It could be used for localize your app.

## Installation

Add this line to your application's Gemfile:

    gem 'strings_xml_localizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strings_xml_localizer

## Usage

First, require it in your file:

```ruby
require 'strings_xml_localizer'
```

### Localize from a string and receive output as a string:

```ruby
input = %Q(
  <?xml version="1.0" encoding="utf-8"?>
  <resources>
      <string name="hello">Hello!</string>
      <string name="hi">Hello!</string>
  </resources>
)
StringsXmlLocalizer.string_to_string(input, tl: :ja)

### OUTPUT
# "\n<resources>\n  <string name=\"hello\">こんにちは！</string>\n  <string name=\"hi\">こんにちは！</string>\n</resources>\n"
###
```

### Localize from a string and write output to file

```ruby
StringsXmlLocalizer.string_to_file(input, to: 'my_output.xml')
```

### Localize from a file and receive output as a string

```ruby
StringsXmlLocalizer.file_to_string(input, from: 'input.xml')
```

### Localize from a file and write output to file

```ruby
StringsXmlLocalizer.file_to_file(from: 'input.xml', to: 'output.xml')
```

### Options:
- `:from`: File to read from, default: `strings.xml`
- `:to`: File to write to, default: `output.xml`
- `:sl`: Source language, default: `auto`
- `:tl`: Target language, default: `en`

## Contributing

1. Fork it ( http://github.com/hoangphanea/strings_xml_localizer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
