class Rating < ActiveRecord::Base

  #t.integer :rating_scale_id
  #t.text :revelation_style
  #t.text :expectation_style
  #t.integer :value

  has_many :expectations, dependent: :destroy
  has_many :revelations, dependent: :destroy
  belongs_to :rating_scale

end
