class Question < ActiveRecord::Base

  #t.integer :rating_scale_id
  #t.text :revelation_style
  #t.text :expectation_style

  belongs_to :rating_scale

  has_many :expectations, dependent: :destroy
  has_many :revelations, dependent: :destroy
  has_many :mind_matches, dependent: :destroy

end
