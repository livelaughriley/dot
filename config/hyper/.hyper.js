// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // term size
    termSize: '80px 30px',

    // default font size in pixels for all tabs
    fontSize: 12,

    // font family with optional fallbacks
    fontFamily: '"DejaVuSansMono Nerd Font","Roboto Mono for Powerline", "Menlo", "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // line height as a relative unit
    lineHeight: 1,

    // letter spacing as a relative unit
    letterSpacing: 0,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#dd6063',

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'UNDERLINE',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: true,

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#121212',

    // terminal selection color
    selectionColor: 'rgba(100,100,100,0.1)',

    // border color (window, tabs)
    borderColor: '#101010',

    // custom CSS to embed in the main window
    css: '',

    // custom CSS to embed in the terminal window
    termCSS: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: false,

    // set to `false` (without backticks and without quotes)
    // if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and
    // without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: false,

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '8px 8px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#191919',
      red: '#d64145',
      green: '#03d37b',
      yellow: '#C7C329',
      blue: '#008bce',
      magenta: '#7b5ef2',
      cyan: '#00add2',
      white: '#e4e7f1',
      lightBlack: '#8897b0',
      lightRed: '#dd6063',
      lightGreen: '#03e786',
      lightYellow: '#1ab5ff',
      lightBlue: '#1ab5ff',
      lightMagenta: '#9982f4',
      lightCyan: '#06d3ff',
      lightWhite: '#fefefe',
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: 'C:\\Program Files\\PowerShell\\6\\pwsh.exe',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['-nologo'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: false,

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: false,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,

    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: 'vertical',

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true,

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
    "tab:new": "Ctrl+Shift+T",
    "tab:new": "Cmd+T",
    "window:new": "Ctrl+Shift+N",
    "window:new": "Cmd+N",
    "window:hamburgerMenu": "",
    "tab:close": "Alt+Shift+W",
    "editor:undo": "Ctrl+Z",
    "editor:redo": "Ctrl+R",
    "editor:selectAll": "Ctrl+A",
    'editor:movePreviousWord': 'Alt+Shift+A',
    'editor:movePreviousWord': 'Ctrl+Shift+A',
    'editor:moveNextWord': 'Alt+Shift+D',
    'editor:moveNextWord': 'Ctrl+Shift+D',      
    "editor:deleteNextWord": "",
    "editor:deletePreviousWord": "Ctrl+Backspace"
  },
};












