# README's are too mainstream.

Markdown is hipster, though.

You have to set the ENV variables of the facebook apps secret and key in omniauth.rb by doing export VARIABLE=value. I will provide you with the values.

#Git Branching Model
This project uses the [git-flow](https://github.com/nvie/gitflow) branching model


#CSS Organization

`modules/` Common site wide stuff like typography, form styles, common buttons. All that.
`views/#{controller_name}` Controller specific stuff
`views/shared` styles for shared/ view partials