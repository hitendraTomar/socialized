class ApplicationService
  class << self
    def call(*arg)
      new(*arg).constructor
    end
  end

  attr_reader :result

  def constructor
    @result = call
    self
  end

  def call
    fail NotImplementedError unless defined?(super)
  end
end
