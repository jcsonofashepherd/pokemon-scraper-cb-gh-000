class Pokemon
  @@all = []

  attr_accessor :id, :name, :type, :hp, :db

  def initialize(id:, name:, type:, hp: = 60, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
    @@all << self
  end

  def self.all
    @@all
  end

  def self.save(name, type, database_connection)
    database_connection.execute("INSERT INTO pokemon (name, type, hp) VALUES (?, ?, ?)", name, type, 60)
  end

  def self.find(id, database_connection)
    pokemon_from_db = database_connection.execute("SELECT * FROM pokemon WHERE id = ?", id)
    name = pokemon_from_db[0][1]
    type = pokemon_from_db[0][2]
    self.new(id: id, name: name, type: type, db: database_connection, hp:)
  end
end
