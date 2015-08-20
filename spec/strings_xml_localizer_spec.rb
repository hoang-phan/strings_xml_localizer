require 'spec_helper'

describe StringsXmlLocalizer do
  let(:src) do
    %Q(
      <?xml version="1.0" encoding="utf-8"?>
      <resources>
          <string name="hello">Hello!</string>
          <string name="hi">Hello!</string>
      </resources>
    )
  end

  let(:expected_result) { "\n<resources>\n  <string name=\"hello\">こんにちは！</string>\n  <string name=\"hi\">こんにちは！</string>\n</resources>\n" }
  let(:from) { 'from.xml' }
  let(:to) { 'to.xml' }

  before do
    allow(GoTranslator).to receive(:translate).and_return('こんにちは！')
  end

  it 'has a version number' do
    expect(StringsXmlLocalizer::VERSION).not_to be nil
  end

  describe '.file_to_file' do
    let(:writer) { double }

    before do
      expect(File).to receive(:open).with(to, 'w').and_yield(writer)
      expect(File).to receive(:open).with(from,'r:UTF-8').and_return(src)
    end

    after do
      StringsXmlLocalizer.file_to_file(from: from, to: to, tl: :ja)
    end

    it 'writes correct string' do
      expect(writer).to receive(:write).with(StringsXmlLocalizer::XML_HEADER)
      expect(writer).to receive(:write).with(expected_result)
    end
  end

  describe '.string_to_file' do
    let(:writer) { double }

    before do
      expect(File).to receive(:open).with(to, 'w').and_yield(writer)
    end

    after do
      StringsXmlLocalizer.string_to_file(src, to: to, tl: :ja)
    end

    it 'writes correct string' do
      expect(writer).to receive(:write).with(StringsXmlLocalizer::XML_HEADER)
      expect(writer).to receive(:write).with(expected_result)
    end
  end

  describe '.file_to_string' do
    before do
      expect(File).to receive(:open).with(from,'r:UTF-8').and_return(src)
    end

    it 'returns correct string' do
      expect(StringsXmlLocalizer.file_to_string(from: from, tl: :ja)).to eq expected_result
    end
  end

  describe '.string_to_string' do
    it 'returns correct string' do
      expect(StringsXmlLocalizer.string_to_string(src, tl: :ja)).to eq expected_result
    end
  end

  describe '.generate_out_resources' do
    let(:resources) { double }
    let(:attributes) { { name: 'name' } }

    before do
      expect(resources).to receive(:string).with(0).and_return double(attributes: attributes)
      expect(StringsXmlLocalizer).to receive(:translate_string_at)
    end

    it 'returns correct result' do
      expect(StringsXmlLocalizer.generate_out_resources(resources).value).to eq 'resources'
    end
  end

  describe '.translate_string_at' do
    let(:resources) { double }
    let(:index) { 1 }
    let(:text) { 'text' }
    let(:source) { :en }
    let(:target) { :ja }
    let(:result) { 'result' }

    before do
      expect(resources).to receive(:string).with(index).and_return(double(text: text))
      expect(GoTranslator).to receive(:translate).with(text, from: source, to: target).and_return(result)
    end

    it 'returns correct result' do
      expect(StringsXmlLocalizer.translate_string_at(resources, index, source, target)).to eq result
    end
  end

  describe '.default_options' do
    let(:expected_result) do
      {
        from: StringsXmlLocalizer::DEFAULT_FROM,
        to: StringsXmlLocalizer::DEFAULT_TO,
        sl: StringsXmlLocalizer::DEFAULT_SOURCE_LANGUAGE,
        tl: StringsXmlLocalizer::DEFAULT_TARGET_LANGUANGE
      }
    end

    it 'returns correct default_options' do
      expect(StringsXmlLocalizer.default_options).to eq expected_result
    end
  end
end