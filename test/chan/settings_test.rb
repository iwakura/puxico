require 'test_helper'
require 'puxico/chan'

class ChanSettingsTest < Test::Unit::TestCase

  def settings
    Puxico::Chan::Settings.new [0, 0, 11], nil
  end

  def o_settings
    Puxico::Chan::Settings.new [0, 0, 128], nil
  end

  def test_titled
    assert settings.titled?
    assert !o_settings.titled?
  end

  def test_wide
    assert settings.wide?
    assert !o_settings.wide?
  end

  def test_power
    assert settings.power?
    assert !o_settings.power?
  end

  def test_offset
    assert !settings.offset?
    assert o_settings.offset?
  end

end
