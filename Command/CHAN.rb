#!/usr/bin/env ruby
class SVDRP::Command::CHAN < SVDRP::BaseCommand
  def next
    self.send "CHAN +"
  end

  def prev
    self.send "CHAN -"
  end

  def setByNumber(number)
    self._setByArg number
  end

  def setById(id)
     self._setByArg id
  end

  def setByName(name)
     self._setByArg name
  end

	def get
		return self.send("CHAN").last
	end

	protected
  def _setByArg(arg)
     self.send "CHAN #{arg}"
  end
end
