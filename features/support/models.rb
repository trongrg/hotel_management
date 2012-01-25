class Class
  def extend?(klass)
    not superclass.nil? and ( superclass == klass or superclass.extend? klass )
  end
end

class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

def models
  Module.constants.select do |constant_name|
    constant = Kernel.const_get constant_name
    if not constant.nil? and constant.is_a? Class and constant.extend? ActiveRecord::Base
      constant
    end
  end
end

def model_names
  models.map do |m|
    m.to_s.underscore.gsub("_", " ")
  end
end
