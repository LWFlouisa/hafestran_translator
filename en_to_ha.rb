## When waking display calender and date.
def waking
  system("date; sleep(3)")
end

## When in production do evolutionary algorithm.
def production
  def translation
    input = File.read("data/input/input.txt").downcase.split(" ")

    translate = {
      'ruh'         => "the-masculine",
      'rah'         =>  "the-feminine",
      'roh'         =>    "the-neuter",
      'yona'        =>             "a",
      'yonei'       =>            "an",
      'yonas'       =>      "a-neuter",
      'eneru'       =>         "black",
      'berena'      =>         "white",
      'erudi'       =>           "red",
      'eviyette'    =>        "purple",
      'beru'        =>           "red",
      'evene'       =>         "green",
      'yeru'        =>        "yellow",
      'eranige'     =>        "orange",
      'enesu'       =>         "North",
      'wesi'        =>          "West",
      'easi'        =>          "East",
      'siuha'       =>         "South",
      'upe'         =>            "up",
      'dio'         =>          "down",
      'feru'        =>       "dorward",
      'biosi'       =>      "backward",
      'iniwa'       =>        "inward",
      'utiwa'       =>       "outward",
      'esakeru'     =>      "sneakers",
      'deruesu'     =>   "dress-shoes",
      'eheru'       =>         "heels",
      'siabi'       =>         "clogs",
      'siabi-biesa' =>  "wooden-clogs",
      'berukiesiti' =>  "birkenstocks",
      'esiadi'      =>       "sandals",
      'tero'        =>      "trousers",
      'sikeru'      =>         "skirt",
      'deresi'      =>         "dress",
      'sehiere'     =>         "shirt",
      'sioki'       =>      "stocking",
      'sitaka'      =>         "socks",
      'sitaki'      =>         "steak",
      'siho-sitaki' =>    "chop-steak",
      'befi'        =>          "beef",
      'shikini'     =>       "chicken",
      'tieru'       =>        "turkey",
      'liam'        =>          "lamb",
      'ehaki'       =>           "elk",
      'deru'        =>          "deer",
      'pirosi'      =>          "porc",
      'bieru'       =>          "bear",
      'siaro'       =>        "carrot",
      'pitat'       =>        "potato",
      'siaba'       =>       "cabbage",
      'sipinas'     =>       "spinach",
      'eretuce'     =>       "lettuce",
      'siwa-pitat'  =>  "sweet-potato",
      'ginie'       =>        "ginger",
      'siquasi'     =>        "squash",
      'piemaki'     =>       "pumpkin",
      'tea'         =>           "tea",
      'siofee'      =>        "coffee",
      'eribos'      =>         "herbs",
    }

    word_01 = translate[input[0]]
    word_02 = translate[input[1]]
    word_03 = translate[input[2]]
    word_04 = translate[input[3]]
    word_05 = translate[input[4]]
    word_06 = translate[input[5]]
    word_07 = translate[input[6]]
    word_08 = translate[input[7]]
    word_09 = translate[input[8]]
    word_10 = translate[input[9]]

    translated = "Translated: #{word_01} #{word_02} #{word_03} #{word_04} #{word_05} #{word_06} #{word_07} #{word_08} #{word_09} #{word_10}"

    puts translated
  end

  def classification
    require "naive_bayes"

    a = NaiveBayes.load('data/baysian/language.nb') 

    b = File.read("data/input/input.txt").downcase.split(" ")

    word_01 = b[0]
    word_02 = b[1]
    word_03 = b[2]
    word_04 = b[3]
    word_05 = b[4]
    word_06 = b[5]
    word_07 = b[6]
    word_08 = b[7]
    word_09 = b[8]
    word_10 = b[9]

    ## Classify Words
    classify_word_01 = a.classify(*word_01)
    classify_word_02 = a.classify(*word_02)
    classify_word_03 = a.classify(*word_03)
    classify_word_04 = a.classify(*word_04)
    classify_word_05 = a.classify(*word_05)
    classify_word_06 = a.classify(*word_06)
    classify_word_07 = a.classify(*word_07)
    classify_word_08 = a.classify(*word_08)
    classify_word_09 = a.classify(*word_09)
    classify_word_10 = a.classify(*word_10)

    classification = "Language classes: #{classify_word_01[0]}, #{classify_word_02[0]}, #{classify_word_03[0]}, #{classify_word_04[0]}, #{classify_word_05[0]}, #{classify_word_06[0]}, #{classify_word_07[0]}, #{classify_word_08[0]}, #{classify_word_09[0]}, #{classify_word_10[0]}"

    puts classification.gsub(" alphabet,", "").gsub(", alphabet", "")
  end

  translation
  classification

  sleep(3)
end

## On break do translation and classification.
def break_activities
  system("curl wttr.in")

  sleep(3)
end

## On sleep pause for some seconds
def sleeping
  sleep(3)
end

## State Machine
require "finite_machine"

ai = FiniteMachine.new do
  event :init,  :none       => :waking
  event :woke,  :waking     => :productive
  event :busy,  :productive => :tired
  event :break, :tired      => :sleeping
  event :sleep, :sleeping   => :waking

  on_enter(:woke)  { |event|
    waking
  }

  on_enter(:busy)  { |event|
    production

    sleep(1)
  }

  on_enter(:break) { |event|
    break_activities

    sleep(1)
  }

  on_enter(:sleep) { |event|
    sleeping

    sleep(1)
  }
end

ai.init

ai.woke

puts "Current AI state is: #{ai.current}."; sleep(1)

ai.busy

puts "Current AI state is: #{ai.current}."; sleep(1)

ai.break

puts "Current AI state is: #{ai.current}."; sleep(1)

ai.sleep
