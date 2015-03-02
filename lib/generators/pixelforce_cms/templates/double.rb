class Double
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations

  def initialize(attrs = {})    
  end

  def persisted?
    false
  end

  def method_missing(method_sym, *arguments, &block)
    return ''
  end

end