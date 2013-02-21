class WeightClass < ActiveRecord::Base
  def name
      n = ""
      n += "%s" % I18n.translate(self.gender) unless self.gender.blank?
      n += ", %s" % I18n.translate(self.beginner_elite) if self.beginner_elite
      n += ", " unless n.blank?
      n += "%s" % self.weight
  end
end
