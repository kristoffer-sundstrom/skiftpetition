class WeightClass < ActiveRecord::Base
  def name(includeAge=false)

      n = []
      n.push "%s" % self.age if includeAge && self.age != "senior"
      n.push "%s" % I18n.translate(self.gender) unless self.gender.blank?
      n.push "%s" % I18n.translate(self.beginner_elite) if self.beginner_elite
      n.push "%s" % self.weight
      n.join(", ")
  end
end
