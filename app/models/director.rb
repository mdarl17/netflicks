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
    # does not return directors with '0' movies associated
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

  def self.find_count(n)
    director_counts = select("directors.*, COUNT(movies.id) AS movie_count").joins(:movies).group("directors.id")
    director = director_counts.find do |director|
      director.movie_count == n.to_i
    end
    return [director] if director
    return []
  end
  
  def self.find_exact(name)
    director = select("directors.*").where("name = ?", name)

    return director if director 
    return []
  end

  def self.find_partial(name)
    result_arr = []
    name_arr = name.split(" ")
    if name_arr.length >= 1
      name_arr.each do |name| 
        director = select("directors.*").where("name ILIKE ?", "%#{name.delete(",")}%")
        return director if director.length >= 1
        return []
      end
    else
      return Director.all
    end
  end
  
end