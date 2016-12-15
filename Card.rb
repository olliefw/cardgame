class Card

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def rank
    rank = (name.split("-"))[0]
    if rank == "Jack"
      rank = 11
    elsif rank == "Queen"
      rank = 12
    elsif rank == "King"
      rank = 13
    elsif rank == "Ace"
      rank = 14
    else
      rank = rank.to_i
    end
  end

  def suit
    suit = (name.split("-"))[1]
  end

  def change_suit(suit)
    rank = (name.split("-"))[0]
    name = "#{rank}-#{suit}"
    @name = name
  end

end
