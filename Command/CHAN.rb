#!/usr/bin/env ruby
class SVDRP::Command::CHAN < SVDRP::BaseCommand
  def next
    result self.send "CHAN +"
  end

  def prev
    result self.send "CHAN -"
  end

  def setByNumber(number)
    return self._setByArg number
  end

  def setById(id)
     return self._setByArg id
  end

  def setByName(name)
     return self._setByArg name
  end

	def get
		return self.send "CHAN"
	end

	protected
  def _setByArg(arg)
     result self.send "CHAN #{arg}"
  end
end
