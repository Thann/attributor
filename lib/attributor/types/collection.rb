

module Attributor

  class Collection
    include Type

    def self.native_type
      return ::Array
    end

    def self.example(options={}, context=nil)
      result = []
      size = rand(10)

      size.times do
        random_type = Attributor::BASIC_TYPES.sample
        result << Attributor::Attribute.new(random_type, options).example(context)
      end

      result
    end

    def self.validate( value, context, attribute )
      errors = []

      # All elements in the collection Array must be of type Attributor::Type
      value.each_with_index do |element, i|
        errors << "Collection #{context}[#{i}] is not an Attributor::Type" unless element.is_a?(Attributor::Type)
      end

      errors
    end
  end
end
