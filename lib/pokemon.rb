class Pokemon
  @@all = []

  attr_accessor :id, :name, :type, :hp, :db

  def initialize(id:, name:, type:, db:, hp: 60)
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
    database_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, database_connection)
    pokemon_from_db = database_connection.execute("SELECT * FROM pokemon WHERE id = ?", id)
    name = pokemon_from_db[0][1]
    type = pokemon_from_db[0][2]
    hp = pokemon_from_db[0][3]
    self.new(id: id, name: name, type: type, db: database_connection, hp: hp)
  end

  def alter_hp(hp, database_connection)
    database_connection.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, :id)
  end

end
