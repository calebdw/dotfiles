return {
  s(
    { trig = 'lreq', dscr = 'assign local var to last require section' },
    fmta([[local <> = require('<>')]], {
      f(function(arg)
        local parts = vim.split(arg[1][1], '.', {
          plain = true,
          trimempty = true,
        })
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  )
}
