require "rrschedule"

class MatchesController < ApplicationController

  def index
    @mats = 2
    weight_classes = "all"

    @weight_classes = {}
    WeightClass.all.each do |wc|
      @weight_classes[wc.id] = wc
    end


    @registrations = {}
    Registration.order("weight_class_id").all(:conditions => {:active => true}).each do |r|
      unless @registrations.has_key? r.weight_class_id
        @registrations[r.weight_class_id] = []
      end
      @registrations[r.weight_class_id].push(r.name)
    end

    @separately = {}
    @class_schedule = {}
    @registrations.each_pair do |weight_class, fighters|
      next unless fighters.length > 1
      if fighters.length > 5
        @separately[weight_class] = fighters
        next
      end

      if fighters.length == 2
        @class_schedule[weight_class] = [
            RRSchedule::Game.new(:team_a => fighters[0], :team_b => fighters[1]),
            RRSchedule::Game.new(:team_a => fighters[1], :team_b => fighters[0]),
            RRSchedule::Game.new(:team_a => fighters[0], :team_b => fighters[1])
        ]
        next
      end

      schedule = RRSchedule::Schedule.new(
          :teams => [fighters],
          :rules => [ RRSchedule::Rule.new(:wday => 5, :gt => ["7:00PM"], :ps => ["field #1"]) ]
      )
      schedule.generate

      @class_schedule[weight_class] = []
      schedule.rounds.each do |r|
        r.each do |round|
          @class_schedule[weight_class].push(round.games.to_a)
        end
         # schedule.rounds.flatten.collect {|r| r.games }
      end
      @class_schedule[weight_class] = @class_schedule[weight_class].flatten.delete_if {|w| w.to_s.include?("dummy") }
    end

  end


  def schedule(teams)
    current_cycle = current_round = 0

    while current_round < teams.size-1 && current_cycle < self.cycles
      t = teams.clone
      games = []

      #process one round
      while !t.empty? do
        team_a = t.shift
        team_b = t.reverse!.shift
        t.reverse!

        x = [team_a,team_b].shuffle

        matchup = {:team_a => x[0], :team_b => x[1]}
        games << matchup
      end
      #done processing round

      current_round += 1

      #Team rotation (the first team is fixed)
      teams = teams.insert(1,teams.delete_at(teams.size-1))

      #add the round in memory
      @rounds ||= []
      @rounds[flight_id] ||= []
      @rounds[flight_id] << Round.new(
        :round => current_round,
        :flight => flight_id,
        :games => games.collect { |g|
          Game.new(
            :team_a => g[:team_a],
            :team_b => g[:team_b]
          )
        }
      )
      #done adding round

      #have we completed a full round-robin for the current flight?
      if current_round == teams.size-1
        current_cycle += 1
        current_round = 0 if current_cycle < self.cycles
      end

    end


  end
end
