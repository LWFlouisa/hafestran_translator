## When waking display calender and date.
def waking
  system("date; sleep(3)")
end

## When in production do evolutionary algorithm.
def production
  def safety_reset
    number = File.read("data/input/number.txt").strip.to_i

    if number > 11
      number = 0
    end

    open("data/input/number.txt", "w") { |f|
      f.puts number
    }
  end

  production.safety_reset

  require "SmartTranslator"

  SmartTranslator::Translate.translate
  SmartTranslator::Translate.classify
  SmartTranslator::Translate.rules_ai

  # Modifies the number value that picks a choice.
  SmartTranslator::Translate.up_index

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
