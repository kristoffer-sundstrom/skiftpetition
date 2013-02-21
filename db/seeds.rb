
weights = false
duo_weights = true
clear_registrations = false
fake_registrations = false

if weights
  WeightClass.delete_all

  gender = "kvinna"
  ["elit", "nyborjare"].each do |prefix|
    "-48 kg, -55 kg, -62 kg, -70 kg, +70 kg".split(", ").each do |weight|
      WeightClass.create!({
                              :age => "senior",
                              :beginner_elite => prefix,
                              :gender => gender,
                              :weight => weight
                          })
    end
  end

  gender = "man"
  ["elit", "nyborjare"].each do |prefix|
    "-55 kg, -62 kg, -69 kg, -77 kg, -85 kg, -94 kg, +94 kg".split(", ").each do |weight|
      WeightClass.create!({
                              :age => "senior",
                              :beginner_elite => prefix,
                              :gender => gender,
                              :weight => weight
                          })
    end
  end


  #U10
  #Flickor: -20 kg, -22 kg, -25 kg, -28 kg, -32 kg, -36 kg, -40 kg, +40 kg
  #Pojkar: -21 kg -24 kg -27 kg -30 kg -34 kg -38 kg -42 kg, +42 kg

  gender = "flickor"
  age = "U10"
  "-20 kg, -22 kg, -25 kg, -28 kg, -32 kg, -36 kg, -40 kg, +40 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  gender = "pojkar"
  "-21 kg, -24 kg, -27 kg, -30 kg, -34 kg, -38 kg, -42 kg, +42 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  #U12
  # Flickor: -22 kg, -25 kg, -28 kg, -32 kg, -36 kg, -40 kg, -44 kg, -48 kg, +48 kg
  # Pojkar: -24 kg, -27 kg, -30 kg, -34 kg -38 kg, -42 kg, -46 kg, -50 kg, +50 kg
  age = "U12"
  gender = "flickor"
  "-22 kg, -25 kg, -28 kg, -32 kg, -36 kg, -40 kg, -44 kg, -48 kg, +48 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  gender = "pojkar"
  "-24 kg, -27 kg, -30 kg, -34 kg, -38 kg, -42 kg, -46 kg, -50 kg, +50 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  # U15
  # Flickor:  -32 kg -36 kg -40 kg, -44 kg, -48 kg, -52 kg, -57 kg, -63 kg, +63 kg
  # Pojkar: -34 kg, -37 kg, -41 kg, -45 kg, -50 kg, -55 kg, -60 kg, -66 kg, +66 kg


  age = "U15"
  gender = "flickor"
  "-32 kg, -36 kg, -40 kg, -44 kg, -48 kg, -52 kg, -57 kg, -63 kg, +63 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  gender = "pojkar"
  "-34 kg, -37 kg, -41 kg, -45 kg, -50 kg, -55 kg, -60 kg, -66 kg, +66 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end


  # U18
  # Flickor: -40 kg, -44 kg, -48 kg, -52 kg, -57 kg, -63 kg, -70 kg, +70 kg
  # Pojkar: -46 kg, -50 kg, -55 kg, -60 kg, -66 kg, -73 kg, -81 kg, +81 kg


  age = "U18"
  gender = "flickor"
  "-40 kg, -44 kg, -48 kg, -52 kg, -57 kg, -63 kg, -70 kg, +70 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

  gender = "pojkar"
  "-46 kg, -50 kg, -55 kg, -60 kg, -66 kg, -73 kg, -81 kg, +81 kg".split(", ").each do |weight|
    WeightClass.create!({
                            :age => age,
                            :gender => gender,
                            :weight => weight
                        })
  end

end

if duo_weights

  ["juniorduo", "seniorduo"].each do |age|

    ["duo mix", "duo damer", "duo herrar"].each do |weight|
      WeightClass.create!({
        :age => age,
        :weight => weight
      })
    end
  end



end


if clear_registrations
  Registration.delete_all
end

if fake_registrations
  seniors = open "db/seniors.txt"

  seniors.each do |line|
    # kvinna, Elit, Senior, Veronica Liljedahl, Linköpings Budoklubb, -70 kg

    line.chomp!
    next unless line.length > 0

    (gender, beginner_elite, age, name, club, weight) = line.split(", ")
    conditions = {
        :gender => gender.downcase,
        :beginner_elite => beginner_elite.downcase,
        :age => age.downcase,
        :weight => weight
    }

    wc = WeightClass.first(:conditions => conditions)

    Registration.create!({
                             :weight_class_id => wc.id,
                             :email => "kaka",
                             :phone => "12345",
                             :age => 20,
                             :club => club,
                             :name => name
                         })

  end


end









