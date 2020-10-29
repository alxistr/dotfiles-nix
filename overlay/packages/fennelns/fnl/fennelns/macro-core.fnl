(local m {})

(fn m.if-not [cond first second]
  `(if (not ,cond)
     ,first
     ,second))

(fn m.when-not [cond ...]
  `(when (not ,cond)
     ,...))

m
