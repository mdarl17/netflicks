class Movie < ApplicationRecord 
  belongs_to :director

  enum rating: { "G": 0, "PG": 1, "PG-13": 2, "R": 3}

  def format_title
    if title.index(",")
      t_arr = title.split(", ")
      len = t_arr.length - 2
      "#{t_arr.last} #{t_arr.slice(0..len).join(" ").delete(",")}"
    end
  end

end