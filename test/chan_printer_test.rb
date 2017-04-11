require 'test_helper'
require 'puxico'

class ChanPrinterTest < Test::Unit::TestCase

  def setup
    @conf = Puxico::RadioConfig.new(chann_file)
  end

  def freqs_printer
    Puxico::ChanPrinter::Freqs.new(@conf.chans)
  end

  def normal_printer
    Puxico::ChanPrinter::Normal.new(@conf.chans)
  end

  def listing(kind)
    Puxico::ChanPrinter::run(@conf.chans, kind)
  end

  def test_freqs_list
    assert_equal '160,05625', freqs_printer.lines.first
  end

  def test_normal_list
    assert_equal ' 30 430,065   NOISE', normal_printer.lines[29]
  end

  def test_freqs_run
    content = listing :freqs
    assert_equal '160,05625', content.lines.first.strip
  end

  def test_normal_run
    content = listing :normal
    assert_equal '  4 160,25625 NSDAO', content.lines[3].chomp
  end

end