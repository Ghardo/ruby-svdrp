#!/usr/bin/env ruby
class SVDRP::Connection
	require 'socket'
	require 'timeout'

	def initialize( hostname = '127.0.0.1', port = 2001, timeout = 10 )
		@hostname = hostname
		@port = port
		@timeout = timeout
	end

	def connect()
    timeout(@timeout) do
      @socket = TCPSocket::new @hostname, @port
    end

		self.recieve
	end

	def recieve
		isReading = true
		data = []
		begin
			result = @socket.gets
			match = /^(?<code>\d{3})(?<indicator>[\s-])(vdr\s|(?<number>\d+)?)(?<data>.*?)$/.match(result)
			self.validate_response match
			data << { 'line' => result, 'number' => match['number'], 'data' => self.strip_or_self!(match['data']) }
			if match['indicator'] != "-"
				isReading = false
			end
		end while isReading
		return data
	end

	def send(command)
		begin
			@socket.puts command
			return self.recieve
		rescue Errno::EPIPE
			@socket = nil
			raise 'SVDRP: Disconnected'
		end
	end

	def disconnect
		self.send "QUIT"
		@socket.close
	end

	protected
  def strip_or_self!(string)
    string.strip! || string
  end

  def validate_response(data)
      error_codes = [451,500,501,502,504,550,554]
      if error_codes.include?(data['code'].to_i)
        raise 'SVDRP Error (%d): %s' % [ data['code'], data['data'] ]
      end
    end

end
