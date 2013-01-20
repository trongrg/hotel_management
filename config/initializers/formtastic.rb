module Formtastic
  module Inputs
    module Base
      module Wrapping
        def wrapper_classes_with_method_name
          classes = wrapper_classes_without_method_name
          classes << ' ' << sanitized_method_name.to_s
        end
        alias_method_chain :wrapper_classes, :method_name
      end
    end
  end
end
