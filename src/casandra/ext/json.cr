module JSON
  def self.build(case convention : Casandra::Cases | Symbol, indent = nil)
    String.build do |str|
      build(str, convention, indent) do |json|
        yield json
      end
    end
  end

  def self.build(io : IO, case convention : Casandra::Cases | Symbol, indent = nil) : Nil
    builder = Casandra::Builder.new(io, convention)
    builder.indent = indent if indent
    builder.document do
      yield builder
    end
    io.flush
  end
end
