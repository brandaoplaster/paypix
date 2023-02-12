class Payer
  attr_accessor :document_number, :name

  def initialize(attributes = {})
    @document_number = attributes[:document_number]
    @name = attributes[:name]

    validate
  end

  private

  def validate
    raise ArgumentError, "name or document is blank" if @name.nil? or @document_number.nil?
  end
end
