#!/usr/bin/env ruby
class SVDRP::Command::CHAN < SVDRP::BaseCommand
	def get
		result = self.send "CHAN"
		return {'number' => result[0]['number'], 'name' => result[0]['data']}
	end
end
