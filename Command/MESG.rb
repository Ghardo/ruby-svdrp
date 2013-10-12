#!/usr/bin/env ruby
class SVDRP::Command::MESG < SVDRP::BaseCommand
	def initialize(connection, message)
	  super connection
	  self.message(message)
	end

	def message(message)
    self.send "MESG #{message}"
	end
end
