require 'test_helper'
require 'puxico'

class ChanPrinterTest < Test::Unit::TestCase

  def setup
    @conf = Puxico::RadioConfig.new(chann_file)
  end

  def freqs_printer
    Puxico::ChanPrinter::Freqs.new(@conf.chans)
  end

  def short_printer
    Puxico::ChanPrinter::Short.new(@conf.chans)
  end

  def long_printer
    Puxico::ChanPrinter::Long.new(@conf.chans)
  end

  def listing(kind)
    Puxico::ChanPrinter::run(@conf.chans, kind)
  end

  def test_freqs_list
    assert_equal '160,05625', freqs_printer.lines.first
  end

  def test_short_list
    assert_equal ' 30 430,065   NOISE', short_printer.lines[29]
  end

  def test_long_list
    assert_equal ' 12 160,450   W H   XXX', long_printer.lines[11]
    assert_equal ' 30 430,065   N L NOISE', long_printer.lines[29]
  end

  def test_freqs_run
    content = listing :freqs
    assert_equal '160,05625', content.lines.first.strip
  end

  def test_short_run
    content = listing :short
    assert_equal '  4 160,25625 NSDAO', content.lines[3].chomp
  end

end
