class Answer < ApplicationRecord
  # RELATIONS
  belongs_to :question

  def self.search(search)
    if search
      where('label LIKE ?', "%#{search}%")
      where('value LIKE ?', "%#{search}%")
      where('information LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
