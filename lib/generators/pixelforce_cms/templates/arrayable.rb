module Arrayable
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_arrayable(*args)
      args.each do |arg|
        target_class = arg.to_s.gsub('_ids', '').camelize
        scope "by_#{arg}".gsub('_ids', '').to_sym, -> (object) do
          case object
          when Integer, String
            where("? = ANY(#{self.table_name}.#{arg})", object)
          when target_class.constantize
            where("? = ANY(#{self.table_name}.#{arg})", object.id)
          when Array
            where("ARRAY[?] && #{arg}", object)
          end 
        end

        class_eval %Q(
          def #{arg.to_s.gsub('_ids', '').pluralize}
            #{target_class}.where(id: #{arg})
          end

          def #{arg}=(ids)
            ids -= [0, nil, ""]
            super(ids)
          end   
        )      
      end
    end
  end

end