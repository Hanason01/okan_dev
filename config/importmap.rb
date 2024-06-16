# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "easytimer", to: "https://cdn.jsdelivr.net/npm/easytimer.js@4.6.0/dist/easytimer.min.js", preload: true
pin "timer", to: "timer.js", preload: false
pin "template", to: "template.js", preload: false
pin "template_edit", to: "template_edit.js", preload: false
pin "timer_setting", to: "timer_setting.js", preload: false
pin "global", to: "global.js"