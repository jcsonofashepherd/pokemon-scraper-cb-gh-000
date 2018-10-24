class Pokemon
  @@all = []

  attr_accessor :id, :name, :type, :db

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @@all << self
  end

  def self.all
    @@all
  end

  def self.save(name, type, database_connection)
    database_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, database_connection)
    pokemon_from_db = database_connection.execute("SELECT name FROM pokemon WHERE id = ?", id)
    self.initialize(id, pokemon_from_db[1], pokemon_from_db[2], database_connection)
  end
end
