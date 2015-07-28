
Spaced repetitions library for elixir; currently has a rough port of SuperMemo2 algorithm.

Hex package is `spaced_repetitions`.

### Installation

1. Add a dependency on `{ :spaced_repetitions, "~> 0.0.1" }` in your
   local `mix.exs` file.
2. Run `mix deps.get`.


### Usage

Mnemosyne/SuperMemo2-style spaced repetitions rely on the user telling us
"how easy or hard was that to remember?", on a scale of 0-5.

```
defmodule MyModule
  def myfunction do

    unlearned     = %SpacedRepetitions.Fact{}
    
    more_familiar = SpacedRepetitions.process_recall( unlearned, 2 )
    learned       = SpacedRepetitions.process_recall( more_familiar, 4 )
    
  end  
end
```

### Todos

The default 1-day/6-day jumps from SM2 need to be tested.

We should cap how far out SM2 can push the next repetition date, and make
this configurable.

We should probably use a protocol, with an implementation for our Fact struct.

We should probably think about whether practical concerns found in most spaced reps
software (like managing the number of cards that are in your hopper at once) belong
here, and in what form.

We could also go higher-level and decouple SM2 from the notion of spaced repetitions,
so that we can let people tweak the algo/behavior a bit more easily. One example might
be the Mnemosyne project's tweaks to SM2. However, some non-SM2-like notions of
Spaced Repetitions that don't rely on users grading their recall (or, worse,
rely on the state of other cards or groups of cards) wouldn't fit as nearly.