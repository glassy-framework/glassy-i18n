require "./spec_helper"

describe Glassy::I18n::Translator do
  it "translate" do
    yaml_data = Glassy::I18n::YAMLData.new(YAML.parse(<<-END
    en:
      name: 'Name'
      age: 'Age'
      company:
        name: 'Company Name'
        slogan: 'My name is %{name}'
    pt-BR:
      name: 'Nome'
      age: 'Idade'
      company:
        name: 'Nome da empresa'
        slogan: 'Meu nome é %{name}'
    END
    ))

    backend = Glassy::I18n::StaticYAMLBackend.new(yaml_data)

    translator = Glassy::I18n::Translator.new(backend, "en")
    translator.t("name").should eq "Name"
    translator.t("age").should eq "Age"
    translator.t("company.name").should eq "Company Name"
    translator.t("company.slogan", {"name" => "Test"}).should eq "My name is Test"
    translator.t("company.not_defined_key").should eq "Not defined key"

    translator = Glassy::I18n::Translator.new(backend, nil)
    translator.t("name").should eq "Name"
    translator.t("age").should eq "Age"
    translator.t("company.name").should eq "Company Name"
    translator.t("company.slogan", {"name" => "Test"}).should eq "My name is Test"

    translator = Glassy::I18n::Translator.new(backend, "pt-BR")
    translator.t("name").should eq "Nome"
    translator.t("age").should eq "Idade"
    translator.t("company.name").should eq "Nome da empresa"
    translator.t("company.slogan", {"name" => "Test"}).should eq "Meu nome é Test"
  end
end
