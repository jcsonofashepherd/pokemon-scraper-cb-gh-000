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
    name = database_connection.execute("SELECT name FROM pokemon WHERE id = ?", id)
    type = database_connection.execute("SELECT type FROM pokemon WHERE id = ?", id)
    self.new(id, name, type, database_connection)
  end
end
