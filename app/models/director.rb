class Director < ApplicationRecord 
  has_many :movies, dependent: :destroy

  validates :name, format: { with: /[a-zA-Z]/ }
  validates :years_active, numericality: { only_integer: true }
  validates :best_director, inclusion: [true, false]
  validates :name, :years_active, presence: true

  def format_name 
    name_arr = name.split(", ")
    len = name_arr.length - 2
    "#{name_arr.last} #{name_arr.slice(0..len).join(" ").delete(",")}"
  end

  def movie_count 
    movies.count
  end

  def self.sort_by(type) 
    if type == "count" 
      select("directors.*, COUNT(movies.id) AS movie_count")
        .joins(:movies)
        .group("directors.id")
        .order("movie_count DESC")
    end
  end

  def self.sort_by_created_at 
    select("directors.*").order("created_at DESC")
  end

end