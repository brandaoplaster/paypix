class AdditionalInfo
  def initialize(**attributes)
    @attributes = attributes
  end

  def method_missing(name, *args)
    if name.to_s.end_with?("=")
      @attributes[name.to_s.chop.to_sym] = args.first
    elsif @attributes.key?(name)
      @attributes[name]
    else
      super
    end
  end
end
