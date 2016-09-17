class StrokeCounter::Keyboard::Logger
  attr_reader :logs

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
