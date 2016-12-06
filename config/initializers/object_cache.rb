module ObjectCache
  @@objects = {}

  def self.lookup key
    @@objects[key.to_sym]
  end

  def self.store key, value
    @@objects[key.to_sym] = value
  end
end
