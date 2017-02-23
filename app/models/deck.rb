class Deck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file)
    Compiler.new(file).compile
  end
  
  def is_party?(file)
    @file = file
    Crack::XML.parse(File.read(@file))["document"]["public"]["character"].class == Array
  end

  def compile_individual(file)
    myXML = Crack::XML.parse(File.read(file))
    deck = Deck.new
    character = CharacterCard.new
    weapons = WeaponCard.new
    armors = ArmorCard.new
    tracked_resources = TrackedResourceCard.new
    spells = SpellCard.new
    skills = SkillCard.new
    defenses = DefensiveAbilityCard.new
    feats = FeatCard.new
    traits = TraitCard.new
    special_abilities = SpecialAbilityCard.new
    special_attacks = SpecialAttackCard.new

    deck.cards = []

    deck.cards << character.create_card(myXML)

    weapons.create_card(myXML, "melee") if myXML["document"]["public"]["character"]["melee"] != nil
    armors.create_card(myXML) if myXML["document"]["public"]["character"]["defenses"]["armor"] != nil
    weapons.create_card(myXML, "ranged") if myXML["document"]["public"]["character"]["ranged"] != nil
    tracked_resources.create_card(myXML) if myXML["document"]["public"]["character"]["trackedresources"] != nil
    spells.create_card(myXML) if myXML["document"]["public"]["character"]["spellsmemorized"] != nil
    skills.create_card(myXML) if myXML["document"]["public"]["character"]["skills"] != nil
    defenses.create_card(myXML) if myXML["document"]["public"]["character"]["defensive"] != nil
    feats.create_card(myXML) if myXML["document"]["public"]["character"]["feats"]["feat"] != nil
    traits.create_card(myXML) if myXML["document"]["public"]["character"]["traits"]["trait"] != nil
    special_abilities.create_card(myXML) if myXML ["document"]["public"]["character"]["otherspecials"]["special"] != nil
    special_attacks.create_card(myXML) if myXML["document"]["public"]["character"]["attack"]["special"] != nil

    weapons.class_cards.each do |wc|
      deck.cards << wc
    end

    armors.class_cards.each do |ac|
      deck.cards << ac
    end

    tracked_resources.class_cards.each do |trc|
      deck.cards << trc
    end

    spells.class_cards.each do |sc|
      deck.cards << sc
    end

    skills.class_cards.each do |sc|
      deck.cards << sc
    end

    defenses.class_cards.each do |sc|
      deck.cards << sc
    end

    feats.class_cards.each do |fc|
      deck.cards << fc
    end

    traits.class_cards.each do |tc|
      deck.cards << tc
    end

    special_abilities.class_cards.each do |sac|
      deck.cards << sac
    end

    special_attacks.class_cards.each do |sac|
      deck.cards << sac
    end

    File.open("public/downloads/deck/attachment/1/#{character.class_cards[:title]}.json", 'wb') do |f|
      f << JSON.pretty_generate(deck.cards)
    end

    self.update_attributes!(document_path: "public/downloads/deck/attachment/1/#{character.class_cards[:title]}.json", name: character.class_cards[:title]) 
  end

  def compile_party(file)
    myXML = Crack::XML.parse(File.read(file))

    myXML["document"]["public"]["character"].each_with_index do |fun_stuff, index|

      deck = Deck.new
      character = CharacterCard.new
      weapons = WeaponCard.new
      armors = ArmorCard.new
      tracked_resources = TrackedResourceCard.new
      spells = SpellCard.new
      skills = SkillCard.new
      defenses = DefensiveAbilityCard.new
      feats = FeatCard.new
      traits = TraitCard.new
      special_abilities = SpecialAbilityCard.new
      special_attacks = SpecialAttackCard.new

      deck.cards = []

      deck.cards << character.create_card(myXML, index)

      weapons.create_card(myXML, "melee", index) if myXML["document"]["public"]["character"][index]["melee"] != nil
      armors.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["defenses"]["armor"] != nil
      weapons.create_card(myXML, "ranged", index) if myXML["document"]["public"]["character"][index]["ranged"] != nil
      tracked_resources.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["trackedresources"] != nil
      spells.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["spellsmemorized"] != nil
      skills.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["skills"] != nil
      defenses.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["defensive"] != nil
      feats.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["feats"]["feat"] != nil
      traits.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["traits"]["trait"] != nil
      special_abilities.create_card(myXML, index) if myXML ["document"]["public"]["character"][index]["otherspecials"]["special"] != nil
      special_attacks.create_card(myXML, index) if myXML["document"]["public"]["character"][index]["attack"]["special"] != nil

      weapons.class_cards.each do |wc|
        deck.cards << wc
      end

      armors.class_cards.each do |ac|
        deck.cards << ac
      end

      tracked_resources.class_cards.each do |trc|
        deck.cards << trc
      end

      spells.class_cards.each do |sc|
        deck.cards << sc
      end

      skills.class_cards.each do |sc|
        deck.cards << sc
      end

      defenses.class_cards.each do |sc|
        deck.cards << sc
      end

      feats.class_cards.each do |fc|
        deck.cards << fc
      end

      traits.class_cards.each do |tc|
        deck.cards << tc
      end

      special_abilities.class_cards.each do |sac|
        deck.cards << sac
      end

      special_attacks.class_cards.each do |sac|
        deck.cards << sac
      end

      File.open('public/downloads/deck/attachment/1/new_file.json', 'wb') do |f|
        f << JSON.pretty_generate(deck.cards)
      end

      self.update_attributes!(document_path: "public/downloads/deck/attachment/1/#{character.class_cards[:title]}.json", name: "public/downloads/deck/attachment/1/#{character.class_cards[:title]}.json") 
    end
  end
end