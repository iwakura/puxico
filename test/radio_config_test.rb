require 'test_helper'
require 'puxico'

class RadioConfigTest < Test::Unit::TestCase

  def setup
    @chann = chann_file
    @conf = Puxico::RadioConfig.new(@chann)
  end

  def teardown
    @chann.close
  end

  def test_correct_config_reconstruction
    conf = @conf.to_s.lines
    orig_lines = chann_file.read.lines
    orig_lines.each_with_index do |line, idx|
      assert_equal line, conf[idx], "Line #{idx} should be equal."
    end
  end

  def test_returns_channels
    assert_respond_to @conf, :chans
    assert_equal Array, @conf.chans.class
    assert_equal 128, @conf.chans.size
  end
end
