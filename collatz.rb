def collatz(integer)
  if integer.odd?
    integer * 3 + 1
  else
    integer / 2
  end
end

$seen_lengths = {}
def check_cache(test_integer, steps)
  $seen_lengths[test_integer] + steps if $seen_lengths[test_integer]
end

def store_cache(test_integer, steps)
  $seen_lengths[test_integer] = steps
end

def find_length(test_integer)
  current_integer = test_integer
  current_steps = 0
  while(current_integer != 1)
    cache_answer = check_cache(current_integer, current_steps)
    if cache_answer
      return store_cache(test_integer, cache_answer)
    end
    current_steps += 1
    current_integer = collatz(current_integer)
  end
  store_cache(test_integer, current_steps)
end

longest = (1..1000000).max_by { |integer| find_length(integer) }

puts longest
