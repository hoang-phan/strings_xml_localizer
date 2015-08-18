require 'strings_xml_localizer/version'
require 'strings_xml_localizer/constants'
require 'go_translator'
require 'ox'

module StringsXmlLocalizer
  def self.file_to_file(options = {})
    options = default_options.merge(options)
    string_to_file(File.open(options[:from],"r:UTF-8",&:read), options)
  end

  def self.file_to_string(options = {})
    options = default_options.merge(options)
    string_to_string(File.open(options[:from],"r:UTF-8",&:read))
  end

  def self.string_to_file(src, options = {})
    options = default_options.merge(options)
    File.open(options[:to], 'w') do |f|
      f.write(XML_HEADER)
      f.write(string_to_string(src))
    end
  end

  def self.string_to_string(src)
    in_xml = Ox.parse(src)
    output = Ox::Document.new(version: '1.0', encoding: 'utf-8')

    in_resources = in_xml.resources
    out_resources = generate_out_resources(in_resources)
    output << out_resources

    Ox.dump(output)
  end

  def self.generate_out_resources(in_resources)
    out_resources = Ox::Element.new('resources')
    i = 0
    while 1
      begin
        out = Ox::Element.new('string')
        out[:name] = in_resources.string(i).attributes[:name]
        out << translate_string_at(in_resources, i, :ja)
        out_resources << out
        i += 1
      rescue
        break
      end
    end
    out_resources
  end

  def self.translate_string_at(resources, index, to)
    GoTranslator.translate(resources.string(index).text, to: to)
  end

  def self.default_options
    {
      from: DEFAULT_FROM,
      to: DEFAULT_TO
    }
  end
end
