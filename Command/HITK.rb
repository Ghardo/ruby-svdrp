#!/usr/bin/env ruby
class SVDRP::Command::HITK < SVDRP::BaseCommand
	def press(key = '')
    return self.send "HITK #{key}"
	end
end
