require 'test_helper'
require 'puxico/chan'

class ChanTitleTest < Test::Unit::TestCase

  def conf_title
    @source = [25, 26, 20, 30, 16]
    Puxico::Chan::Title.from_conf @source
  end

  def title
    Puxico::Chan::Title.new 'NOISE'
  end

  def test_reconstruction
    assert_equal 'NOISE', conf_title.title
  end

  def test_convertion
    t = conf_title
    assert_equal @source, t.to_a
  end

  def test_construction
    assert_equal 'NOISE', title.title
  end

  def test_clean_title
    t = title
    t.clean!
    assert_equal '~~~~~', t.title
    assert t.blank?
  end
end
