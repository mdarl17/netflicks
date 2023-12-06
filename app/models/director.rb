class Director < ApplicationRecord 
  has_many :movies, dependent: :destroy

  validates :name, format: { with: /[a-zA-Z]/ }
  validates :years_active, numericality: { only_integer: true }
  validates :best_director, inclusion: { in: [true, false] }, allow_blank: false
  validates :name, :years_active, presence: true
  # TODO why issues w/ setup data that has :best_director value??
  # validates :best_director, presence: true

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
  
  def self.find_name(name)
    result_arr = []
    name.split(" ").each do |str|
      director = select("directors.*").where("name ILIKE ?", "%#{str}%")
      if director
        result_arr.push(director)
      end
    end
    return result_arr.flatten.uniq
  end
  
  def self.find_count(n)
    director_counts = select("directors.*, COUNT(movies.id) AS movie_count").joins(:movies).group("directors.id")
    director = director_counts.find do |director|
      director.movie_count == n.to_i
    end
    return [director] if director
    return []
  end

end