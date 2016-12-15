
	require "./Card"
require "./Player"
require "./Deck"


def crazy_eights

  deck = Deck.new

  puts "What is your name player?"
  name = gets.chomp.to_s
  player = Player.new(name)
  cpu = Player.new("The Computer")

  deck.shuffle
  deck.deal(player, cpu, 14)

  puts "Welcome #{player.name}, it's time to play craaaaazy eights!"

  card_on_top = deck.top_card

  while player.cards.length > 0 && cpu.cards.length > 0
    card_on_top = player_turn(card_on_top, player, deck)

    card_on_top = computer_turn(card_on_top, cpu, deck)
  end

  if player.cards.length > 0
    puts "You lose, better luck next time!"
  elsif cpu.cards.length > 0
    puts "YOU WIN!!!"
  end

end

def player_turn(card_on_top, player, deck)
  puts "The card on top is #{card_on_top.name}"

  puts "You have:"
  player.cards.each do |card|
    puts card.name
  end
  puts ""

  n = 0

  playable_card_list = []

  puts "You can play:"
  player.cards.each do |card|
    if card_on_top.rank == card.rank || card_on_top.suit == card.suit || card.rank == 8
      puts "#{n}. #{card.name}"
      n += 1
      playable_card_list.push(card)
    end
  end
  puts ""

  if n == 0
    puts "Since you have no playable cards you have to draw until you get one that you can play"
    drawn_card = deck.top_card
    puts "You drew a #{drawn_card.name}"
    while card_on_top.rank != drawn_card.rank && card_on_top.suit != drawn_card.suit && drawn_card.rank != 8
      player.add_card(drawn_card)
      drawn_card = deck.top_card
      puts "You drew a #{drawn_card.name}"
    end
    puts ""

    card_on_top = drawn_card
  else
    card_number = 99999

    puts "Type the number of the card you want to play"
    card_number = gets.chomp.to_i

    while card_number < 0 || card_number > (n - 1)
      puts "That number isn't one in the list, please type another one"
      card_number = gets.chomp.to_i
    end
    puts ""

    card_on_top = player.play_selected_card(playable_card_list[card_number])
  end

  if card_on_top.rank == 8
    puts "Since you played and 8 you get to choose the new suit"
    puts "0. Heart"
    puts "1. Diamond"
    puts "2. Club"
    puts "3. Spade"

    suit_number = gets.chomp.to_i
    while suit_number < 0 || suit_number > 3
      puts "That number isn't one in the list, please type another one"
      suit_number = gets.chomp.to_i
    end

    if suit_number == 0
      card_on_top.change_suit("Heart")
    elsif suit_number == 1
      card_on_top.change_suit("Diamond")
    elsif suit_number == 2
      card_on_top.change_suit("Club")
    elsif suit_number == 3
      card_on_top.change_suit("Spade")
    end
  end

  puts "The new card on top is #{card_on_top.name}"

  return card_on_top
end

def computer_turn(card_on_top, cpu, deck)
  playable_card_list = []

  cpu.cards.each do |card|
    if card_on_top.rank == card.rank || card_on_top.suit == card.suit || card.rank == 8
      playable_card_list.push(card)
    end
  end

  if playable_card_list.length == 0
    drawn_card = deck.top_card
    puts "#{cpu.name} drew a card"
    while card_on_top.rank != drawn_card.rank && card_on_top.suit != drawn_card.suit && drawn_card.rank != 8
      cpu.add_card(drawn_card)
      drawn_card = deck.top_card
      puts "#{cpu.name} drew another card"
    end
    puts ""

    card_on_top = drawn_card
  else
    card_on_top = cpu.play_selected_card(playable_card_list[0])
  end

  if card_on_top.rank == 8

    suit_number = rand(4)

    if suit_number == 0
      card_on_top.change_suit("Heart")
    elsif suit_number == 1
      card_on_top.change_suit("Diamond")
    elsif suit_number == 2
      card_on_top.change_suit("Club")
    elsif suit_number == 3
      card_on_top.change_suit("Spade")
    end
  end

  puts "The new card on top is #{card_on_top.name}"

  return card_on_top
end

crazy_eights
