#!/usr/bin/env ruby
require 'SVDRP.rb'

class SVDRP::BaseCommand
	def initialize(connection)
		@svdrp = connection
	end

	def send(command)
		@svdrp.connect
		result = @svdrp.send command
		@svdrp.disconnect

		return result
	end
end
