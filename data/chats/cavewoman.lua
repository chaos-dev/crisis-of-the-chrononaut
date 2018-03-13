-- Crisis of the Chrononaut
-- Copyright (C) 2018 Chaos-Dev
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

first_word = {"Gog", "Der", "Goo", "Gut", "Dun", "Bad", "Dab", "Pad", "Pag"}
other_word = {"der", "def", "und", "foo", "fum", "fee", "fi", "pag", "gaa",
              "gut", "dun", "pun", "pag", "gap", "grod", "gru", "daf", "do"}
punctuation = {"!", ".", "?"}

newChat{
  id="first",
  text = "\""..rng.table(first_word).." "..rng.table(other_word).." "..rng.table(other_word).." "..rng.table(other_word)..rng.table(punctuation).."\"",
  answers = {
    {[["I can't understand you"]],
     jump="second"},
    {[["Goodbye"]]},
  }
}

newChat{
  id="second",
  text = "\""..rng.table(first_word).." "..rng.table(other_word).." "..rng.table(other_word).." "..rng.table(other_word)..rng.table(punctuation).."\"",
  answers = {
    {[["I can't understand you"]],
     jump="third"},
    {[["Goodbye"]]},
  }
}

newChat{
  id="third",
  text = "\""..rng.table(first_word).." "..rng.table(other_word).." "..rng.table(other_word).." "..rng.table(other_word)..rng.table(punctuation).."\"",
  answers = {
    {[["I can't understand you"]],
     jump="fourth"},
    {[["Goodbye"]]},
  }
}

newChat{
  id="fourth",
  text = "[Talking very slowly] \""..rng.table(first_word).." "..rng.table(other_word).." "..rng.table(other_word).." "..rng.table(other_word).."!\"",
  answers = {
    {[["I can't understand you"]],
     action = function(npc, player)
       player:useEnergy(game.energy_to_act)
       game.log("The cavewoman walks away in frustration.")
     end
    },
    {[["Goodbye"]]},
  }
}

return "first"
