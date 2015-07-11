require_relative "attribute.rb"

class ModelConfiguration
  class Association < Attribute

    ID_REGEXP = /_id\z/

    def association_class
      if properties[:class_name].present?
        properties[:class_name]
      else
        name.sub(ID_REGEXP, "").camelize
      end
    end

    def as_factory_name
      ":#{association_class.underscore}"
    end

    # some_thing_id -> ":some_thing_id"
    # some_thing -> ":some_thing_id"
    def as_field_name
      if name =~ ID_REGEXP
        as_symbol
      else
        "#{as_symbol}_id"
      end
    end

    def is_association?
      true
    end

    # Models

    def association_implementation
      ModelConfiguration::Association::ModelImplementation.new(self).to_s
    end

    # Factories

    def as_factory_declaration
      ModelConfiguration::Association::FactoryDeclaration.new(self).to_s
    end

  end
end

require_relative "association/factory_declaration.rb"
require_relative "association/model_implementation.rb"