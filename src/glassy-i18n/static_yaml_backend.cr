require "i18n"

module Glassy::I18n
  # Static `YAML` backend.
  #
  # It **MUST** be populated with data explicitly upon creation.
  #
  class StaticYAMLBackend < ::I18n::Backend
    # :nodoc:
    def load
      return
    end

    def initialize(data)
      @data = data.raw_yaml_data
    end
  end
end
