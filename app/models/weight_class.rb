class WeightClass < ActiveRecord::Base
  def name
      n = "%s" % I18n.translate(self.gender)
      if self.beginner_elite
        n += ", %s" % I18n.translate(self.beginner_elite)
      end
      n+= ", %s" % self.weight
  end
end
