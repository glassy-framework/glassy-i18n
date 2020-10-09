require "yaml"

module Glassy::I18n
  class Translator
    def initialize(@backend : StaticYAMLBackend, @locale : String?)
    end

    def t(key : String, params : Hash? = nil) : String
      ::I18n.backend = @backend
      locale = @locale

      if locale.nil?
        locale = ::I18n.locale || ::I18n.default_locale
      end

      count = nil

      if !params.nil? && params.has_key?("count")
        count = params["count"].not_nil!.to_i
      end

      result = ::I18n.t(key, locale: locale.not_nil!, count: count)

      if result =~ /^MISSING: .+/
        last_key = key.split(".").last
        result = last_key.gsub("_", " ").capitalize
      end

      unless params.nil? || result.nil?
        result = result % params
      end

      result
    end
  end
end
