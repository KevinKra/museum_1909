class Musuem
  attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    patron.interests.map do |interest|
      @exhibits.find {|exhibit| exhibit.name == interest}
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    output = Hash[@exhibits.map {|exhibit| [exhibit, []]}]
    # forgive me
    @patrons.each do |patron|
      patron.interests.each do |interest|
        output.each do |key,value|
          if key.name == interest
            value << patron
          end
        end
      end
    end
    output
  end

  def patrons_of_exhibits
    output = Hash[@exhibits.map {|exhibit| [exhibit, []]}]
    @patrons.each do |patron|
      patron.interests.each do |interest|
        output.each do |key,value|
          if key.name == interest && patron.spending_money >= key.cost
            # patron.spend_money(key.cost)
            value << patron
          end
        end
      end
    end
    output
  end
end