return {
  -- Laravel Classes
  s(
    { trig = '_c', dscr = 'class constructor' },
    fmta(
      [[
				public function __construct(
					<>
				) {
					<><>
				}
			]],
      {
        i(1),
        c(2, {
          t('parent::__construct();'),
          t(''),
        }),
        i(0),
      }
    )
  ),
  s(
    { trig = '_i', dscr = 'class invoke' },
    fmta(
      [[
				public function __invoke(<>)<> {
					<>
				}
			]],
      { i(1), i(2), i(0) }
    )
  ),

  -- -- Laravel Models

  -- -- Laravel Factories
  s(
    { trig = 'state', dscr = 'laravel factory state' },
    fmta(
      [[
				public function <>(): Factory
				{
					return $this->>state(fn (array $attributes) =>> [
						<>
					]);
				}
			]],
      { i(1), i(0) }
    )
  )
}
