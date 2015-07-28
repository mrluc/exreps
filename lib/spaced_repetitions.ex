defmodule SpacedRepetitions do
  use Timex

  # TODO clean up to support use as protocol
  defmodule Fact do
    defstruct [easiness_factor: 2.5,
      number_repetitions: 0,
      quality_of_last_recall: nil,
      repetition_interval: nil,
      next_repetition: nil,
      last_studied: nil]
  end

  def process_recall(fact, quality) do
    fact = %{fact | quality_of_last_recall: quality }

    process_easiness( fact )
    |> process_repetition_interval
    |> schedule_next_repetition
  end

  # --- private ---
  defp process_easiness(fact=%Fact{ quality_of_last_recall: quality }) when quality < 3 do
    %{fact | number_repetitions: 0, repetition_interval: 0}
  end
  defp process_easiness(fact=%Fact{ easiness_factor: ef, quality_of_last_recall: q }) do
    %{fact | easiness_factor: calc_ef(ef, q) }
  end

  defp process_repetition_interval(fact=%Fact{ quality_of_last_recall: q,
                                              number_repetitions: reps,
                                              easiness_factor: ease,
                                              repetition_interval: interval }) do
    %{fact | repetition_interval:  calc_interval( q, reps, ease, interval )}
  end
  
  defp schedule_next_repetition(fact) do
    next_rep = Date.now |> Date.add( Time.to_timestamp( fact.repetition_interval, :days))
    %{fact | next_repetition: next_rep, last_studied: Date.now }
  end

  defp calc_interval( quality, _reps, _ease, _interval ) when quality == 3, do: 0
  defp calc_interval( _quality, reps, _ease, _interval ) when reps+1 == 1,  do: 1
  defp calc_interval( _quality, reps, _ease, _interval ) when reps+1 == 2,  do: 6
  defp calc_interval( _quality, _reps, ease, interval ),                    do: interval * ease

  
  defp calc_ef( ef, q ) do
    ef - 0.8 + (0.28 * q) - (0.02 * q * q)
    |> easiness_floor
  end
  
  defp easiness_floor(easiness) when easiness < 1.3, do: 1.3
  defp easiness_floor(easiness),                     do: easiness
end
