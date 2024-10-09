# frozen_string_literal: true

RSpec.describe LightningcssRails::Compressor do
  subject { described_class.new }

  let(:basic_css) do
    <<-CSS
      .foo {
        padding-top: 1px;
        padding-left: 2px;
        padding-bottom: 3px;
        padding-right: 4px;
      }
    CSS
  end
  let(:compressed_css) { ".foo{padding:1px 4px 3px 2px}" }

  context "when lightningcss library is installed" do
    before do
      allow(subject).to receive(:library_enabled?).and_return(true)
    end

    context "when lightningcss compression was successful" do
      before do
        allow(subject).to receive(:process_files).and_return([true, compressed_css])
      end

      it do
        expect(Rails.logger).to receive(:info).with(described_class::COMPRESSION_SUCCESS_MESSAGE)
        expect(subject.compress(basic_css)).to eq(compressed_css)
      end
    end

    context "when lightningcss compression failed" do
      before do
        allow(subject).to receive(:process_files).and_return([false, basic_css])
      end

      it do
        expect(Rails.logger).to receive(:warn).with(described_class::COMPRESSION_FAILURE_MESSAGE)
        expect(subject.compress(basic_css)).to eq(basic_css)
      end
    end
  end

  context "when lightningcss library does not installed" do
    before do
      allow(subject).to receive(:library_enabled?).and_return(false)
    end

    it do
      expect(Rails.logger).to receive(:warn).with(described_class::LIBRARY_NOT_FOUND_MESSAGE)
      expect(subject.compress(basic_css)).to eq(basic_css)
    end
  end

  it "has a version number" do
    expect(LightningcssRails::VERSION).not_to be nil
  end
end
