require 'test_helper'
require 'puxico/chan'

class ChanFreqTest < Test::Unit::TestCase

  def conf_freq
    @source = [0, 80, 17, 22]
    Puxico::Chan::Freq.from_conf @source
  end

  def freq
    Puxico::Chan::Freq.new 16115000
  end

  def test_config_parsing
    assert_equal 16115000, conf_freq.dhz
    assert_equal '161,150', conf_freq.to_num
    assert_equal @source, conf_freq.to_a
  end

  def test_num_parsing_with_dot
    freq1 = '144.025'
    freq = Puxico::Chan::Freq.from_num freq1
    assert_equal 14402500, freq.dhz
    assert_equal '144,025', freq.to_num
  end

  def test_num_parsing_with_comma
    freq1 = '442,0625'
    freq = Puxico::Chan::Freq.from_num freq1
    assert_equal 44206250, freq.dhz
    assert_equal freq1, freq.to_num
  end

  def test_construction
    assert_equal 16115000, freq.dhz
    assert_equal '161,150', freq.to_num
  end

  def test_defined
    assert !freq.undefined?
    assert !conf_freq.undefined?
  end

  def test_undefined
    freq = Puxico::Chan::Freq.new 0
    assert freq.undefined?
  end

  def test_undefined2
    freq = Puxico::Chan::Freq.from_conf [255, 255, 255, 255]
    assert freq.undefined?
  end

  def test_blanking
    freq1 = freq
    assert !freq1.undefined?
    freq1.clean!
    assert freq1.undefined?
  end
end


