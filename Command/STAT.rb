#!/usr/bin/env ruby
class SVDRP::Command::STAT < SVDRP::BaseCommand
	def get(disk)
    return self.send "STAT #{disk}"
	end
end
