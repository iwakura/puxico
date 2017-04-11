module Puxico
  module ChanPrinter

    def self.kinds
      constants.collect {|k| k.to_s.downcase }.sort
    end

    def self.run(chans, kind)
      pcn = kind.to_s.sub(/^\w/){|c| c.upcase }
      klass = const_get pcn
      printer = klass.new(chans)
      printer.content
    end

    class Base

      def initialize(chans)
        @chans = chans
      end

      def lines
        @chans.each_with_index.collect do |ch, idx|
          line(ch, idx) unless ch.undefined?
        end.compact
      end

      def content
        lines.join "\n"
      end

      def line(ch, idx)
        '%-9s %5s' % [ch.frequency, ch.clean_title]
      end
    end

    class Freqs < Base
      def line(ch, idx)
        '%-9s' % ch.frequency
      end
    end

    class Short < Base
      def line(ch, idx)
        '%3d %-9s %5s' % [idx + 1, ch.frequency, ch.clean_title]
      end
    end

    class Long < Base
      def line(ch, idx)
        '%3d %-9s %1s %1s %5s' % [idx + 1, ch.frequency, ch.band, ch.power, ch.clean_title]
      end
    end

    class Complete < Base
      def line(ch, idx)
        '%3d %-9s %-9s %1s %1s %5s' % [idx + 1, ch.frequency, ch.offset, ch.band, ch.power, ch.clean_title]
      end
    end
  end
end
