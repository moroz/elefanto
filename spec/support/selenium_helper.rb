module SeleniumHelper
  def self.included(base)
    base.class_eval do
      self.use_transactional_tests = false if metadata[:js]
    end
  end
end