class Player

  attr_accessor :name
  attr_reader :cards

  def initialize(name, cards = [])
    @cards = cards
    @name = name
  end

  def add_card(card)
    cards.push(card)

    @cards = cards
  end

  def play_card
    return cards.delete_at(0)
  end

  def play_selected_card(card)
    return cards.delete(card)
  end

  def shuffle
    cards.shuffle!

    @cards = cards
  end

end
