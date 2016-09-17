class StrokeCounter::Keyboard::Logger
  def initialize(args = {})
    @logs = []
  end

  def add_log(log)
    if log.is_a? Hash
      @logs << log
      true
    else
      false
    end
  end
end
