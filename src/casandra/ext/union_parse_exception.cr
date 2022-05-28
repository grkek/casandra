class JSON::UnionParseException < JSON::ParseException
  def initialize(target, source, causes, line_number, column_number)
    message = <<-EOS
      Couldn't parse #{target} from #{source}, all alternatives failed:
      #{causes.map(&.message).join '\n'}
    EOS
    super(message, line_number, column_number)
  end
end
