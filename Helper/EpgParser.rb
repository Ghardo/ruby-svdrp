#!/usr/bin/env ruby

class SVDRP::Helper::EpgParser
  attr_reader :entries

  def initialize
    @entries = []

    @Channel = {
      'id'      => nil,
      'name'      => nil,
      'channelEpg'  => []
    }

    @EPGEntry = {
      'eventId'     => nil,
      'begin'     => nil,
      'duration'    => nil,
      'tableId'     => nil,
      'tableVersion'  => nil,
      'title'     => nil,
      'shortText'   => nil,
      'description'   => nil,
      'vps'     => nil,
      'stream'    => {}
    }

    @EPGEntryStream = {
      'stream'    => nil,
      'type'      => nil,
      'language'    => nil,
      'description' => nil,
    }
  end

  def parse_line(line)
    channel = /^C (?<id>.*?) (?<name>.*?)$/.match(line)
    if channel != nil
      @entries.push(@Channel.clone)
      @entries.last['id'] = channel['id']
      @entries.last['name'] = channel['name']
    end

    match_new = /^E (?<eventId>\d+) (?<begin>\d+) (?<duration>\d+) (?<tableId>\d+)\s?(?<tableVersion>\d+)?/.match(line)
    if match_new != nil
      self.getEpgRoot.push(@EPGEntry.clone)
      self.getEpgRoot.last['eventId'] = match_new['eventId'].to_i
      self.getEpgRoot.last['begin'] = match_new['begin'].to_i
      self.getEpgRoot.last['duration'] = match_new['duration'].to_i
      self.getEpgRoot.last['tableId'] = match_new['tableId'].to_i
      if match_new['tableVersion'] != nil
        self.getEpgRoot.last['tableVersion'] = match_new['tableVersion'].to_i
      end
    end

    match_texts = /^(?<key>[TSD]) (?<text>.*?)$/.match(line)
    if match_texts != nil
      case  match_texts['key']
        when 'T'
          self.getEpgRoot.last['title'] = match_texts['text']
        when 'S'
          self.getEpgRoot.last['shortText'] = match_texts['text']
        when 'D'
          self.getEpgRoot.last['description'] = match_texts['text']
      end
    end

    match_vps = /^V (?<vps>\d+)/.match(line)
    if match_vps != nil
      self.getEpgRoot.last['vps'] = match_vps['vps'].to_i
    end

    match_stream = /^X (?<stream>[12]) (?<type>\d+) (?<language>.*?) (?<description>.*?)$/.match(line)
    if match_stream != nil
      stream = match_stream['stream'].to_i
      self.getEpgRoot.last['stream'][stream] = @EPGEntryStream.clone
      self.getEpgRoot.last['stream'][stream]['stream'] = stream
      self.getEpgRoot.last['stream'][stream]['type'] = match_stream['type']
      self.getEpgRoot.last['stream'][stream]['language'] = match_stream['language']
      self.getEpgRoot.last['stream'][stream]['description'] = match_stream['description']
    end
  end

  protected
  def getEpgRoot
    if @entries.last != nil and @entries.last.key?('channelEpg')
      return @entries.last['channelEpg']
    else
      return @entries
    end
  end
end