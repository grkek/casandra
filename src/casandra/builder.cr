module Casandra
  class Builder < JSON::Builder
    property convention : Cases

    def initialize(io : IO, case _convention = Cases::Snake)
      super(io)
      @convention = _convention.is_a?(Cases) ? _convention : Cases.parse _convention.to_s
    end

    def format_key(key)
      case @convention
      in Cases::Snake  then key
      in Cases::Camel  then key.camelcase lower: true
      in Cases::Pascal then key.camelcase
      in Cases::Kebab  then key.gsub /_/, '-'
      end
    end

    def field(name, value)
      super(format_key(name), value)
    end

    def field(name)
      super(format_key(name)) { yield }
    end
  end
end
