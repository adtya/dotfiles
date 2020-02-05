#!/bin/sh

color00="28/2a/36" # Base 00 - Black
color08="44/47/5a" # Base 03 - Bright Black

color01="ff/55/55" # Base 08 - Red
color09="ff/65/65" # Base 08 - Bright Red

color02="50/fa/7b" # Base 0B - Green
color10="60/ff/8b" # Base 0B - Bright Green

color03="f1/fa/8c" # Base 0A - Yellow
color11="ff/ff/9c" # Base 0A - Bright Yellow

color04="bd/93/f9" # Base 0D - Blue
color12="cd/a3/ff" # Base 0D - Bright Blue

color05="ff/79/c6" # Base 0E - Magenta
color13="ff/89/d6" # Base 0E - Bright Magenta

color06="8b/e9/fd" # Base 0C - Cyan
color14="9b/f9/ff" # Base 0C - Bright Cyan

color07="f8/f8/f2" # Base 05 - White
color15="ff/ff/ff" # Base 07 - Bright White

color16="ef/69/b6"
color17="e1/ea/7c"
color18="28/28/28"
color19="38/38/38"
color20="ad/83/e9"
color21="e8/e2/e8"
color_foreground="f8/f8/f2"
color_background="28/2a/36"

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background

