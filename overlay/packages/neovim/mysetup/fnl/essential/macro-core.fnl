(local m {})

(fn m.if-not [cond first second]
  `(if (not ,cond)
     ,first
     ,second))

(fn m.when-not [cond ...]
  `(when (not ,cond)
     ,...))

(fn m.tpush [t val]
  `(tset ,t (+ 1 (length ,t)) ,val))

(fn m.tmap [f col]
  `(let [col# ,col
         f# ,f]
     (each [k# v# (pairs col#)]
       (tset col# k# (f# v#)))
     col#))

(fn m.treduce [f initial col]
  `(do
     (var memo# initial)
     (let [f# ,f]
       (each [k# v# (pairs col#)]
         (set memo# (f# memo# v# k#)))
       memo#)))

(fn m.tjoin [sep col]
  `(table.concat ,col ,sep))

m
