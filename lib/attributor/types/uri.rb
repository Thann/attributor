# Represents a href type.
require 'uri'

module Attributor
  class URI
    include Attributor::Type

    def self.family
      String.family
    end

    def self.valid_type?(value)
      case value
      when ::String, ::URI::Generic
        true
      else
        false
      end
    end

    def self.native_type
      return ::URI::Generic
    end

    def self.example(context=nil, options={})
      URI(/[:uri:]/.gen)
    end

    def self.load(value, context=Attributor::DEFAULT_ROOT_CONTEXT, **options)
      return nil if value.nil?
      case value
      when self.native_type
        value
      when ::String
        URI(value)
      else
        raise CoercionError, context: context, from: value.class, to: self, value: value
      end
    end

    def self.validate(value,context=Attributor::DEFAULT_ROOT_CONTEXT,attribute)
      []
    end

    def check_option!(name, definition)
      # No options are supported
      :unknown
    end

  end
end

class Randgen
  def self.uri
    "http://example.com/#{word}/#{rand(10 ** 9)}"
  end
end
