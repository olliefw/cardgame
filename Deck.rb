class Deck

  require "./Card"
  require "./Player"

  attr_accessor :names, :cards

  def initialize(cards = [])
    @names = ["Ace-Heart", "2-Heart", "3-Heart", "4-Heart", "5-Heart", "6-Heart", "7-Heart", "8-Heart", "9-Heart", "10-Heart", "Jack-Heart", "Queen-Heart", "King-Heart", "Ace-Diamond", "2-Diamond", "3-Diamond", "4-Diamond", "5-Diamond", "6-Diamond", "7-Diamond", "8-Diamond", "9-Diamond", "10-Diamond", "Jack-Diamond", "Queen-Diamond", "King-Diamond", "Ace-Club", "2-Club", "3-Club", "4-Club", "5-Club", "6-Club", "7-Club", "8-Club", "9-Club", "10-Club", "Jack-Club", "Queen-Club", "King-Club", "Ace-Spade", "2-Spade", "3-Spade", "4-Spade", "5-Spade", "6-Spade", "7-Spade", "8-Spade", "9-Spade", "10-Spade", "Jack-Spade", "Queen-Spade", "King-Spade"]
    52.times do |n|
      cards.push(Card.new(names[n%names.size]))
    end
    @cards = cards
  end

  def shuffle
    cards.shuffle!

    @cards = cards
  end

  def deal(player1, player2, amount_of_cards)
    player_card = 0

    amount_of_cards.times do |card|
      if player_card == 0
        player1.add_card(cards[0])
        player_card = 1
      else
        player2.add_card(cards[0])
        player_card = 0
      end
      cards.delete_at(0)
    end

  end

  def top_card
    return cards.delete_at(0)
  end

end
