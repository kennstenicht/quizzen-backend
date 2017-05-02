class Question < ApplicationRecord
  # RELATIONS
  has_many :answers

  def self.search(search)
    if search
      where('label LIKE ?', "%#{search}%")
      where('source LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
