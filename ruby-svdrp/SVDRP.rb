#!/usr/bin/env ruby
scriptself=File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
scriptpath=File.realdirpath(File.dirname(scriptself))
$LOAD_PATH.unshift(scriptpath)
module SVDRP
end
module SVDRP::Command
end
module SVDRP::Helper
end

require 'Connection.rb'
require 'BaseCommand.rb'
require 'Helper/EpgParser.rb'
require 'Command/CHAN.rb'
require 'Command/LSTE.rb'
