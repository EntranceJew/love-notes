# Chat
[17:14] <billiam> Asked yesterday, but what are the steps for using the luajit profiler in a love game?
[17:15] <+slime> replace luajit 2.0 with 2.1-alpha, and then http://repo.or.cz/w/luajit-2.0.git/blob_plain/refs/heads/v2.1:/doc/ext_profiler.html
[17:15] <+slime> (require("jit.p").start(options) instead of luajit -jp)
[17:16] <billiam> slime: where 'replacing luajit' looks something like: https://love2d.org/wiki/Building_L%C3%96VE ?
[17:17] <+slime> well, you can just build luajit separately and then replace the library
[17:17] <+slime> depending on the OS
[17:17] <+slime> (without rebuilding all of love)
[17:17] <+slime> replacing luajit would be http://repo.or.cz/w/luajit-2.0.git/blob_plain/refs/heads/v2.1:/doc/install.html
[17:18] <+slime> (after getting the latest 2.1-alpha source from the git repository)
[17:18] <+slime> MiuStar: love uses luajit 2.0, but the luajit profiler is only available in luajit 2.1-alpha
[17:19] <billiam> Thanks, I'll give that a shot. I don't have a lot of faith in my ability to successfully build under windows. I don't suppose there are any love builds floating around with 2.1a?

# Code
```lua
require("jit.p").start(options)
```