module Puxico
  class RadioConfig

    attr_reader :preamble, :chans, :settings

    def initialize(io)
      lines = io.read.split("\r\n")
      @preamble = lines.first
      @chans = lines[1..128].collect {|c| Chan::Base.from_conf c }
      @settings = lines[129..-1]
    end

    def to_s
      [preamble, chans, settings, "\r\n"].flatten.collect(&:to_s).join("\r\n")
    end

  end

end
