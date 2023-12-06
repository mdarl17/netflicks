class Movie < ApplicationRecord 
  belongs_to :director
  
  validates :title, format: { with: /[a-zA-Z]/ }, presence: true
  validates :rating, format: { with: /(g|pg|[pg\-13]|r)/i }, presence: true
  validates :released, numericality: { only_integer: true }, presence: true
  # TODO why are valid values returning 'false' in being present?
  validates :sex, :nudity, :violence, inclusion: { in: [true, false] }, allow_blank: false
  # validates :sex, :nudity, :violence, presence: true, allow_blank: false
  

  validates_length_of :released, minimum: 0, maximum: Time.now.year

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

  # def self.adult_content 
  #   where("sex = true OR nudity = true")
  # end

  # def self.violence
  #   where(violence: true)
  # end

  def self.sort_movies(type)
    if type == "alpha"
      self.select("movies.*").order("title ASC")
    end
  end

  def self.mature_content
    movies = where("sex = true OR nudity = true OR violence = true")
    return movies unless movies.empty?
    return []
  end

  def self.released_after(year) 
    select("movies.*").where("movies.released > ?", year)
  end

  def self.exact_search(title)
    movie = select("movies.*").where("title = ?", title)
    return movie unless movie.empty? 
    return []
  end

  def self.partial_search(title) 
    movie = select("movies.*").where("title ILIKE ?", "%#{title}%")
    return movie unless movie.empty?
    return []
  end

end