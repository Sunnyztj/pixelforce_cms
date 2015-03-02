module PrettyUrl
  extend ActiveSupport::Concern

  included do
    after_save :update_url_name
  end

  module ClassMethods
    def find(id, options = {})
      if id.is_a?(String)
        real_id = /(.*\-)?(?<id>\d+)\Z/.match(id)[:id]
      else
        real_id = id
      end
      super(real_id, options)
    end
  end

  def to_param
    url_name
  end

  private
  def update_url_name
    self.url_name = "#{name.to_url}-#{id}" if name_changed? and !url_name_changed?    
  end

end