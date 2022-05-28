class Object
  def to_json(case convention : Casandra::Cases | Symbol)
    String.build do |str|
      to_json str, convention
    end
  end

  def to_json(io : IO, case convention : Casandra::Cases | Symbol)
    JSON.build(io, convention) do |json|
      to_json(json)
    end
  end

  def from_json(string_or_io, case convention : Casandra::Cases | Symbol)
    parser = Casandra::PullParser.new(string_or_io, convention)
    new parser
  end

  def from_json(string_or_io, root : String, case convention : Casandra::Cases | Symbol)
    parser = Casandra::PullParser.new(string_or_io, convention)
    parser.on_key!(root) do
      new parser
    end
  end
end
