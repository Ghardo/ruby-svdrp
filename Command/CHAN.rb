#!/usr/bin/env ruby
class SVDRP::Command::CHAN < SVDRP::BaseCommand
	def getName
		result = self.send "CHAN"
		return result[0]['data']
	end

	def get
		result = self.send "CHAN"
		return result[0]['number']
	end
end
