module Casandra
  class PullParser < JSON::PullParser
    property convention : Cases

    def initialize(input, case _convention = Cases::Snake)
      super(input)
      @convention = _convention.is_a?(Cases) ? _convention : Cases.parse _convention.to_s
    end

    def read_object_key
      case @convention
      in Cases::Snake then read_string
      in Cases::Pascal, Cases::Camel
        read_string.underscore
          .gsub(/(?!^)(?<![0-9_])[0-9]+/) { |number| "_#{number}" }
          .gsub(/[0-9]+(?![0-9_])(?!$)/) { |number| "#{number}_" }
      in Cases::Kebab then read_string.gsub /\-/, '_'
      end
    end
  end
end
