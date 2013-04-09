module MatchesHelper

  def mat(weight_class)
    mat = ""
    if weight_class.beginner_elite == "elit"
      mat = "A"
    elsif (weight_class.age == "senior" && weight_class.beginner_elite == "nyborjare") || weight_class.age == "U18"
      mat = "B"
    end

    mat
  end

  def am_pm(weight_class)
    ["senior", "seniorduo", "U18"].include?(weight_class.age) ? "EM" : "FM"
  end

end