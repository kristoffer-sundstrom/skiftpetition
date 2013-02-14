class WeightClass < ActiveRecord::Base
  def name
      n = "%s" % self.gender
      if self.beginner_elite
        n += ", %s" % self.beginner_elite
      end
      n+= ", %s" % self.weight
  end
end
