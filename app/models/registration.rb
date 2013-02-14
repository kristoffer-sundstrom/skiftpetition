class Registration < ActiveRecord::Base
  has_one :weight_class

  validates :name, :email, :phone, :age, :club, :weight_class_id, :presence => true


end
