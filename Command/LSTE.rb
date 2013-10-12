#!/usr/bin/env ruby
class SVDRP::Command::LSTE < SVDRP::BaseCommand
  require "time"

  def initialize(connection, channel = '')
    super connection
    @channel = channel
  end

  def setChannel(channel)
    @channel = channel
  end

  def get()
    result = self.send "LSTE"
    return self.parse(result)
  end

  def now()
    result = self.send "LSTE #{@channel} now"
    return self.parse(result)
  end

  def next()
    result = self.send "LSTE #{@channel} next"
    return self.parse(result)
  end

  def at(time)
    result = self.send "LSTE #{@channel} at #{time}"
    return self.parse(result)
  end

  def parse(result)
    epg = SVDRP::Helper::EpgParser.new
    result.each{|data|
      epg.parse_line data['data']
    }
    return epg.entries
  end
end
