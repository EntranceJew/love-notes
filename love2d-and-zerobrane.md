# Love2D and ZeroBrane

## Getting output when you run from ZeroBrane
Put this at the head of your `main.lua`, or before a particularly important print.
```lua
io.stdout:setvbuf("no")
```

### Note
If you're using windows, love 0.9.2, and ZeroBrane Studio < 0.95 you might have issues doing the above.
* Ensure `t.console = true` isn't in your `conf.lua`.
* Don't use `love._openConsole()` in your code.

## Getting the debugger to work.
You do not need this to get a console to open.
Make sure the beginning of your `love.load()` looks like this:
```lua
love.load(arg)
	if arg[#arg] == "-debug" then
		-- if your game is invoked with "-debug" (zerobrane does this by default)
		-- invoke the debugger
		require("mobdebug").start()
	end
	-- ... your code here ...
end
```
If you ever need to delay your debugger or only invoke it at a given point, you can use:
```
local mobdebug = require("mobdebug")
mobdebug.start()
-- your code here
mobdebug.stop()
```
[Read More](http://notebook.kulchenko.com/zerobrane/love2d-debugging)

## Live Updating
Use `Ctrl+F6` to run your game in a way that allows you to modify variables on the fly. Might not work for complex games.