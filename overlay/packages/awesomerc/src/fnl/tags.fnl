(let [moses (require :moses)
      repeat (fn [what count]
               (moses.rep what (or count 9)))]
  {:heaven (repeat "☰")
   :heaven2 (repeat "≣")
   :arabic [1 2 3 4 5 6 7 8 9]
   :runes ["ᚠ" "ᚢ" "ᚦ" "ᚨ" "ᚱ" "ᚲ" "ᚷ" "ᚹ" "ᚺ"] ; "ᚾ" "ᛁ" "ᛃ" "ᛇ" "ᛈ" "ᛉ" "ᛊ" "ᛏ" "ᛒ" "ᛖ" "ᛗ" "ᛚ" "ᛜ" "ᛟ" "ᛞ"
   :latin ["α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι"]
   :chinese ["一" "二" "三" "四" "五" "六" "七" "八" "九"]
   :traditional-chinese ["壹" "貳" "叄" "肆" "伍" "陸" "柒" "捌" "玖"]
   :east-arabic ["٢" "٣" "٤" "٥" "٦" "٧" "٨" "٩" "١"]
   :persian-arabic ["٠" "١" "٢" "٣" "۴" "۵" "۶" "٧" "٨"]
   :rorepeatan ["Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ"]
   :thai ["๑" "๒" "๓" "๔" "๕" "๖" "๗" "๘" "๙"]
   :round (repeat "◯")
   :peace (repeat "☮")
   :star (repeat "⛧")
   :cross (repeat "✜")
   :diarepeatond-suit (repeat "◆")
   :medium-small-white-circle (repeat "⚬")
   :black-circle (repeat "●")
   :filled-dot (repeat "⚫")
   :black-small-square (repeat "▪")
   :black-meduim-small-square (repeat "◾")})
