require "glassy-kernel"

module Glassy::I18n
  class Bundle < Glassy::Kernel::Bundle
    SERVICES_PATH = "#{__DIR__}/config/services.yml"

    HAS_CONTAINER_EXT = true

    macro apply_container_ext(all_bundles)
      def i18n_yaml_data_raw(context : Glassy::Kernel::Context? = nil) : YAML::Any
        Glassy::I18n::YAMLData.read_yaml_files([
          {% for bundle in all_bundles %}
            {% if bundle.resolve.constant("LOCALE_PATH") %}
              {{ bundle.id }}::LOCALE_PATH,
            {% end %}
          {% end %}
        ] of String)
      end
    end
  end
end
