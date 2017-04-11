module Puxico
  module ChanPrinter
    KINDS = [:normal, :freqs]

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
    end

    class Freqs < Base
      def line(ch, idx)
        '%-9s' % ch.frequency
      end
    end

    class Normal < Base
      def line(ch, idx)
        '%3d %-9s %5s' % [idx + 1, ch.frequency, ch.clean_title]
      end
    end
  end
end
