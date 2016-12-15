require "./Card"
require "./Player"
require "./Deck"

# WAR 
deck = Deck.new
player1 = Player.new("Player 1")
player2 = Player.new("Player 2")

deck.shuffle
deck.deal(player1, player2, 52)

def play(player1, player2)
  cards_in_play = []
  runs = 0

  while (!player1.cards.empty? && !player2.cards.empty?)
    runs += 1
    if runs % 100 == 0
      player1.shuffle
      player2.shuffle
    end

    player1_card = player1.play_card
    player2_card = player2.play_card

    puts "#{player1.name} played a #{player1_card.name}"
    puts "#{player2.name} played a #{player2_card.name}"

    cards_in_play.push(player1_card, player2_card)

    winner = determine_winner(player1, player2, player1_card, player2_card)

    while winner == 0
      winner_and_cards = play_war(player1, player2)
      winner_and_cards[1].each do |card|
        cards_in_play.push(card)
      end

      winner = winner_and_cards[0]
    end

    while !cards_in_play.empty?
      card = cards_in_play.delete_at(0)
      winner.add_card(card)
    end

  end

  if player1.cards.empty?
    puts "#{player1.name} is out of cards, game over"
  end

  if player2.cards.empty?
    puts "#{player2.name} is out of cards, game over"
  end
end

def play_war(player1, player2)
  cards = []

  if player1.cards.length <= 2
    puts "#{player1.name} doesn't have enough cards to play war"
    how_many_cards = player1.cards.length + 1

    how_many_cards.times do
      cards.push(player1.play_card)
    end

    winner = player2
  elsif player2.cards.length <= 2
    puts "#{player2.name} doesn't have enough cards to play war"
    how_many_cards = player1.cards.length + 1

    how_many_cards.times do
      cards.push(player1.play_card)
    end

    winner = player1
  else

    player1_facedown_card = player1.play_card
    player1_faceup_card = player1.play_card
    player2_facedown_card = player2.play_card
    player2_faceup_card = player2.play_card

    puts "#{player1.name} played a face-down card and a #{player1_faceup_card.name}"
    puts "#{player2.name} played a face-down card and a #{player2_faceup_card.name}"
    puts ""

    cards.push(player1_facedown_card, player1_faceup_card, player2_facedown_card, player2_faceup_card)

    winner = determine_winner(player1, player2, player1_faceup_card, player2_faceup_card)

    if winner != 0
      puts "#{winner.name} has won the war"
      puts ""
    end

  end

  winner_and_cards = [winner, cards]

  return winner_and_cards
end

def determine_winner(player1, player2, player1_card, player2_card)
  if player1_card.rank > player2_card.rank
    puts "#{player1.name} wins the hand"
    winner = player1
  elsif player1_card.rank < player2_card.rank
    puts "#{player2.name} wins the hand"
    winner = player2
  else
    puts "There is a tie, THIS MEANS WAR!!!"
    winner = 0
  end
  puts ""
  return winner
end

play(player1, player2)
