require "./spec_helper"
require "./fixtures/read_yaml_files/class_one"
require "./fixtures/read_yaml_files/class_two"

describe Glassy::I18n::YAMLData do
  it "read yaml files" do
    yaml_data_raw = Glassy::I18n::YAMLData.read_yaml_files([
      ClassOne::LOCALE_PATH,
      ClassTwo::LOCALE_PATH,
    ])

    yaml_data = Glassy::I18n::YAMLData.new(yaml_data_raw)
    yaml_data.available_languages.should eq ["en", "pt-BR"]
    yaml_data.get_best_language(["pt-BR", "en"]).should eq "pt-BR"
    yaml_data.get_best_language(["ru"]).should eq nil

    expected = <<-YAML
    ---
    en:
      name: Name 2
      type: Type
      company:
        name: Company Name
        type: Company Type
      age: Age
    pt-BR:
      name: Nome
    YAML

    yaml_data.raw_yaml_data.to_yaml.should eq "#{expected}\n"
  end
end
