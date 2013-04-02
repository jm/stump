class Object
  def safe_meta_def method_name, &block
    metaclass.remember_original_method(method_name)
    meta_eval {
      define_method(method_name) {|*args, &block|
        method_body.call(*args, &block)
      }
    }
  end

  def reset(method_name)
    metaclass.restore_original_method(method_name)
  end

  protected

  def remember_original_method(method_name)
    alias_method "__original_#{method_name}".to_sym, method_name if method_defined?(method_name)
    self
  end

  def restore_original_method(method_name)
    original_method_name = "__original_#{method_name}".to_sym
    if method_defined?(original_method_name)
      alias_method method_name, original_method_name
      remove_method original_method_name
    end
    self
  end
end