class Director < ApplicationRecord 
  has_many :movies

  validates :name, format: { with: /[a-zA-Z]/ }
  validates :years_active, numericality: { only_integer: true }
  validates :best_director, inclusion: [true, false]
  validates :name, :years_active, :best_director, presence: true

  def format_name 
    name_arr = name.split(", ")
    len = name_arr.length - 2
    "#{name_arr.last} #{name_arr.slice(0..len).join(" ").delete(",")}"
  end

  def movie_count 
    movies.count
  end

  def self.sort_by_created_at 
    select("directors.*").order("created_at DESC")
  end

end