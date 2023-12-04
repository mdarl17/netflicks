class Movie < ApplicationRecord 
  belongs_to :director
  
  validates :title, format: { with: /[a-zA-Z]/ }, presence: true
  validates :released, :rating, numericality: { only_integer: true }, presence: true
  validates :sex, inclusion: [true, false]
  validates :nudity, inclusion: [true, false]
  validates :violence, inclusion: [true, false]

  enum rating: { "G": 0, "PG": 1, "PG-13": 2, "R": 3}

  def format_title
    if title.index(",")
      t_arr = title.split(", ")
      len = t_arr.length - 2
      "#{t_arr.last} #{t_arr.slice(0..len).join(" ").delete(",")}"
    else
      return title
    end
  end

end