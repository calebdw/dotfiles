return {
  s(
    { trig = 'stan-return', dscr = 'phpstan return never' },
    fmta(
      [[/** @phpstan-return never */<>]],
      { i(0) }
    )
  ),
  s(
    { trig = 'stan-constructor', dscr = 'phpstan consistent constructor' },
    fmta(
      [[/** @phpstan-consistent-constructor */<>]],
      { i(0) }
    )
  ),
  s(
    { trig = 'stan-ignore', dscr = 'phpstan ignore' },
    fmta(
      [[/** @phpstan-ignore <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = 'stan-dump', dscr = 'phpstan dump' },
    fmta(
      [[\PHPStan\dumpType(<>);]],
      { i(1) }
    )
  ),
  s(
    { trig = '@var', dscr = 'phpstan var' },
    fmta(
      [[/** @var <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@extends', dscr = 'phpstan extends' },
    fmta(
      [[/** @extends <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@return', dscr = 'phpstan return' },
    fmta(
      [[/** @return <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@param', dscr = 'phpstan param' },
    fmta(
      [[/** @param <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@mixin', dscr = 'phpstan mixin' },
    fmta(
      [[/** @mixin <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@todo', dscr = 'phpstan todo' },
    fmta(
      [[/** @todo <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@see', dscr = 'phpstan see' },
    fmta(
      [[/** @see <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@deprecated', dscr = 'phpstan deprecated' },
    fmta(
      [[/** @deprecated <> */]],
      { i(1) }
    )
  ),
  s(
    { trig = '@use', dscr = 'phpstan use' },
    fmta(
      [[/** @use <> */]],
      { i(1) }
    )
  ),
}
