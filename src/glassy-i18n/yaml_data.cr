require "yaml"

module Glassy::I18n
  class YAMLData
    property raw_yaml_data : YAML::Any

    def initialize(@raw_yaml_data : YAML::Any)
    end

    def available_languages : Array(String)
      @raw_yaml_data.raw.as(Hash).keys.map {|k| k.raw.as(String) }
    end

    def get_best_language(languages : Array(String)) : String?
      availables = available_languages

      languages.each do |lang|
        if availables.includes?(lang)
          return lang
        end
      end

      return nil
    end

    macro read_yaml_files(folders)
      yaml_str = {{ run("#{__DIR__}/scripts/merge_files", folders.map { |s| s.resolve }.join('|')) }}
      YAML.parse(yaml_str)
    end
  end
end
