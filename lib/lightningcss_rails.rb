# frozen_string_literal: true

require_relative "lightningcss_rails/version"
require "tempfile"

module LightningcssRails
  class Compressor
    LIBRARY_NOT_FOUND_MESSAGE   = "Lightningcss library was not found. Continue with uncompressed CSS string.".freeze
    COMPRESSION_SUCCESS_MESSAGE = "CSS string was successfully compressed by Lightningcss.".freeze
    COMPRESSION_FAILURE_MESSAGE = "Compression by Lightningcss failed, continue with uncompressed CSS string.".freeze

    def compress(css_string)
      if library_enabled?
        process_string(css_string)
      else
        puts LIBRARY_NOT_FOUND_MESSAGE
        css_string
      end
    end

    private

    def library_enabled?
      system("npx lightningcss -V")
    end

    def process_string(css_string)
      status, css_string = process_files(css_string)

      if status
        puts COMPRESSION_SUCCESS_MESSAGE
      else
        puts COMPRESSION_FAILURE_MESSAGE
      end

      css_string
    end

    def process_files(css_string)
      source_file = Tempfile.new("source")
      result_file = Tempfile.new("result")
      source_file.write(css_string)
      source_file.rewind

      status = call_lightningcss_library(source_file.path, result_file.path)
      result_file.rewind

      result = result_file.read
      result_file.close

      source_file.unlink
      result_file.unlink

      [status, result]
    end

    def call_lightningcss_library(source_path, target_path)
      system("npx lightningcss --minify --bundle --targets '>= 0.25%' #{source_path} -o #{target_path}")
    end
  end
end
