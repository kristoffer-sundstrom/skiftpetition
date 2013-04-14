

["u10", "u12", "u15"].each do |age|
  classes = []
  wc = nil
  next_class = []
  total_matches = 0

  File.open("/tmp/%s.txt" % age).each do |line|
    total_matches += 1
    line_wc = line.split("\t")[2]
    if wc != line_wc
      classes.push next_class unless wc.nil?
      print line_wc
      next_class = []
      wc = line_wc
    end
    next_class.push(line)
  end
  classes.push next_class

  matching = []
  while classes.length > 1

    first = classes.shift
    second = classes.shift

    until first.empty? || second.empty?
      f = first.shift
      s = second.shift
      matching.push(f)
      matching.push(s)
      #print "f: %s, s: %s, lf: %s, ls: %s" % [f, s, first.length, second.length]
    end

    # print "first: %s, second: %s\n" % [first, second]

    classes.unshift(first) unless first.empty?
    classes.unshift(second) unless second.empty?
  end

  matching += classes.flatten

  f = File.open("/tmp/%s_matched.txt" % age, "w")
  f.write(matching.join(""))
  f.close
  print matching.join("")
end