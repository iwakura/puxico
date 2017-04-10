require 'test_helper'
require 'puxico/chan'

class ChanBaseTest < Test::Unit::TestCase

  def setup
    @source = ' 0  101  0  67  0  0  0  1  0  0  1  11  11  11  11  11 '
  end

  def conf_chan
    Puxico::Chan::Base.from_conf @source
  end

  def test_correct_reconstruction
    assert_equal @source, conf_chan.to_s
  end
end

