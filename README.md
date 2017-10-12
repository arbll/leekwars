# LeakWars kiting AI
An attempt at an AI for the online game [LeakWars](https://leekwars.com/) written in CoffeeScript.

## Approach

The idea behind this AI logic is to abuse the spell "Spark" wich has a long-range and can hit targets behind walls. To do this successfully we need more movement point than our opponent and enough damage to kill him before he catches up to us.

The AI will always try to avoid taking any damage. If it is not possible, it will try to do the maximum damage while trying not to lose too much health (by avoiding weapons line of sight for example).

## Kwon bugs

* If the opponent has too much spells and weapon equiped, the AI may take too long to execute and the system will kill it, resulting in defeat.

## Compilation

You can run `compile.bat` on windows or use the command contained inside on any other platform.

Because LeakWars code is not real javascript (but extremely close), you might stumble on some errors.

## Example

Some context : our player is named "LeGrandKebab", cells are colored by our AI : red means we can take damage from weapon, yellow means we can take damage from spells and green means the opponent has no way to hit us. Blue is for debug.

![exemple.gif](/exemple.gif)
*TheSuspect getting destroyed by our AI*
