require 'test/unit'

class Test::Unit::TestCase

  def chann_file
    conf_path = File.join(File.dirname(__FILE__), 'data', 'sample.chann')
    File.open(conf_path)
  end


end
