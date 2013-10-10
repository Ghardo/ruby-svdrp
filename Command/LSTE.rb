#!/usr/bin/env ruby
class SVDRP::Command::LSTE < SVDRP::BaseCommand
  require "time"

  def now(channel)
    result = self.send "LSTE #{channel} now"
    return self.parse(result)
  end

  def next(channel)
    result = self.send "LSTE #{channel} next"
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
