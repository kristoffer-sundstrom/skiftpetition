class Registration < ActiveRecord::Base
  has_one :weight_class

  validates :name, :email, :phone, :age, :club, :weight_class_id, :presence => true

  def self.clubs
    Registration.select(:club).uniq.collect {|r| r.club}.sort
  end


end
