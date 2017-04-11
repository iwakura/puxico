module Puxico
  module Chan
    class Base
      attr_reader :freq, :rep_offset, :settings, :title

      def self.from_conf(raw)
        digits = raw.scan(/\d+/).collect(&:to_i)
        freq = digits[0..3]
        rep_offset = digits[4..7]
        settings = digits[8..10]
        title = digits[11..15]
        new(freq, rep_offset, settings, title)
      end

      def initialize(freq, rep_offset, settings, title)
        @freq = Freq.from_conf(freq)
        @rep_offset = RepOffset.from_conf(rep_offset, self)
        @title = Title.from_conf(title)
        @settings = Settings.new(settings, self)
      end

      def to_s
        [' ', [freq, rep_offset, settings, title].collect(&:to_a).flatten.collect(&:to_s).join('  '), ' '].join
      end

      def clean_offset!
        rep_offset.clean!
      end

      def clean_settings!
        settings.clean!
      end

      def clean_title!
        title.clean!
      end

      def clean_freq!
        freq.undefine!
      end

      def undefine!
        [:clean_freq!, :clean_title!, :clean_offset!, :clean_settings!].each {|m| send m }
      end

      def undefined?
        freq.undefined?
      end

      def untitled?
        title.blank?
      end

      def clean_title
        title.clean
      end

      def frequency
        freq.to_num
      end

      def offset
        settings.offset? ? rep_offset.to_num : ''
      end

      def power
        settings.power? ? 'H' : 'L'
      end

      def band
        settings.wide? ? 'W' : 'N'
      end

      include Comparable

      def <=>(other)
        freq.value <=> other.freq.value
      end
    end

    class Freq
      attr_reader :dhz

      def self.from_conf(digits, chan = nil)
        dhz = digits.collect {|d| '%02d' % d.to_s(16) }.reverse.join.to_i rescue 0
        new(dhz, chan)
      end

      def self.from_num(num, chan = nil)
        dhz = (num.to_s.tr(',', '.').strip.to_f * 100000).to_i
        new(dhz, chan)
      end

      def initialize(dhz, chan = nil)
        @dhz = dhz
        @chan = chan
      end

      def to_a
        if undefined?
          default
        else
          ('%08d' % dhz).scan(/\d\d/).collect {|d| d.to_i(16) }.reverse
        end
      end

      def to_num
        quotient, modulus = dhz.divmod(100000)
        modulus = ('%05d' % modulus).sub(/0?0$/, '')
        "#{quotient},#{modulus}"
      end

      def undefined?
        0 == dhz
      end

      def undefine!
        @dhz = 0
      end
      alias_method :clean!, :undefine!

      def default
        [255] * 4
      end

      def value
        undefined? ? 1_000_000_000 : dhz
      end

    end

    class RepOffset < Freq
      attr_reader :chan

      def default
        [chan.undefined? ? 255 : 0] * 4
      end
    end

    class Settings
      attr_reader :digits, :chan

      def initialize(digits, chan)
        @digits = digits
        @chan = chan
      end

      def to_a
        digits
      end

      def clean!
        @digits = chan.undefined? ? [255, 255, 255] : [0, 0, default_settings]
      end

      def default_settings
        "0000#{chan.untitled? ? 0 : 1}0#{wide? ? 1 : 0}#{power? ? 1 : 0}".to_i(2)
      end

      def power?
        1 == (bits & 1)
      end

      def wide?
        2 == (bits & 2)
      end

      def titled?
        8 == (bits & 8)
      end

      def offset?
        128 == (bits & 128)
      end

      def bits
        digits[2]
      end
    end

    class Title
      CHARS = [(1..9).collect(&:to_s), '0', '', ' ', ('A'..'Z').to_a ].flatten

      attr_reader :title

      def self.from_conf(digits)
        title = digits.collect {|d| CHARS[d.to_i] || '~'}.join
        new title
      end

      def initialize(title)
        @title = title
      end

      def clean!
        @title = '~' * 5
      end

      def to_a
        ('%-5s' % title).chars.collect {|c| CHARS.find_index(c) || 255 }[0..4]
      end

      def clean
        @title.delete('~').strip
      end

      def blank?
        clean.empty?
      end
    end
  end
end
