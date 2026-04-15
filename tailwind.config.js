/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './themes/jmp/layouts/**/*.html',
    './layouts/**/*.html',
    './content/**/*.md',
  ],

  safelist: [
    // Regime section — classes set dynamically via data/regime.yaml
    // Danger
    'border-danger', 'bg-danger/10', 'border-danger/30', 'bg-danger', 'text-danger',
    // Boom
    'border-boom',   'bg-boom/10',   'border-boom/30',   'bg-boom',   'text-boom',
    // Mid-Market
    'border-mid', 'bg-mid/10', 'border-mid/30', 'bg-mid', 'text-mid',
  ],

  theme: {
    extend: {
      colors: {
        navy:   { DEFAULT: '#1B2A4A', deep: '#111D33' },
        gold:   { DEFAULT: '#C8A951', dark: '#A8891F' },
        cream:  '#F8F7F4',
        silk:   '#E5E3DF',
        ink:    '#1A1A1A',
        muted:  '#6B7280',
        danger: '#E74C3C',
        mid:   '#27AE60',
        boom:    '#F1C40F',
      },
      fontFamily: {
        display: ['"Playfair Display"', 'serif'],
        sans:    ['"Source Sans 3"', 'sans-serif'],
        mono:    ['"DM Mono"', 'monospace'],
      },
      letterSpacing: {
        ultra: '0.2em',
      },
      maxWidth: {
        content: '820px',
      },
      backgroundImage: {
        'dot-grid': 'radial-gradient(circle, rgb(27 42 74 / 0.08) 1px, transparent 1px)',
      },
      backgroundSize: {
        dot: '20px 20px',
      },
      keyframes: {
        fadeUp: {
          from: { opacity: '0', transform: 'translateY(16px)' },
          to:   { opacity: '1', transform: 'translateY(0)' },
        },
        pulseDot: {
          '0%, 100%': { opacity: '1',   transform: 'scale(1)' },
          '50%':       { opacity: '0.5', transform: 'scale(0.8)' },
        },
      },
      animation: {
        'fade-1':    'fadeUp 0.55s 0ms   ease both',
        'fade-2':    'fadeUp 0.60s 100ms ease both',
        'fade-3':    'fadeUp 0.60s 200ms ease both',
        'fade-4':    'fadeUp 0.60s 300ms ease both',
        'pulse-dot': 'pulseDot 2s ease-in-out infinite',
      },
      typography: ({ theme }) => ({
        DEFAULT: {
          css: {
            '--tw-prose-body':        theme('colors.ink'),
            '--tw-prose-headings':    theme('colors.navy.DEFAULT'),
            '--tw-prose-links':       theme('colors.navy.DEFAULT'),
            '--tw-prose-bold':        theme('colors.ink'),
            '--tw-prose-quotes':      theme('colors.muted'),
            '--tw-prose-quote-borders': theme('colors.gold.DEFAULT'),
            '--tw-prose-captions':    theme('colors.muted'),
            '--tw-prose-code':        theme('colors.navy.DEFAULT'),
            '--tw-prose-hr':          theme('colors.silk'),
            maxWidth: 'none',
            h1: { fontFamily: '"Playfair Display", serif' },
            h2: { fontFamily: '"Playfair Display", serif' },
            h3: { fontFamily: '"Playfair Display", serif' },
          },
        },
      }),
    },
  },
  plugins: [
  ],
}
