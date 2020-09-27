(fn inc [v] (+ 1 v))
(fn dec [v] (- 1 v))

(fn nil? [v] (if (= nil v) true false))

(fn append [table value]
  (let [new-index (inc (length table))]
    (tset table new-index value)
    table))

(fn range* [i pred]
  (fn r [a b d]
    (match [a b d]
      [a nil nil] (r i a 1)
      [a b nil] (r a b 1)
      ([a b d] ? (< b a)) (r b a d)
      _ (let [s {:i a :m []}]
          (while (pred s.i b)
            (append s.m s.i)
            (set s.i (+ s.i d)))
          s.m))))

(local range (range* 0 #(< $1 $2)))
(local irange (range* 1 #(<= $1 $2)))

(fn reduce [f initial col]
  (if (= 0 (length col))
    initial
    (let [[first & rest] col]
      (reduce f (f initial first) rest))))

(fn filter [f col]
  (-> (fn [memo item]
        (if (f item)
          (append memo item)
          memo))
      (reduce [] col)))

(fn map [f col]
  (-> (fn [memo value]
        (append memo (f value)))
      (reduce [] col)))

(fn tuples [col]
  (let [s {:t {}
           :k (next col nil)}]
    (while (not (nil? s.k))
      (append s.t [s.k (. col s.k)])
      (set s.k (next col s.k)))
    s.t))

(fn map-indexed [col start]
  (let [s {:i (if (nil? start) 1 start)}
        t col]
    (-> (fn [item]
          (let [index s.i]
            (set s.i (inc s.i))
            [index item]))
        (map t))))

(-> ["ok" "wtf" "wow"]
    (map-indexed)
    (s.pp))

(-> {:a "ok" :b "wtf" :c "wow"}
    (map-indexed)
    (s.pp))

;(fn partition [n col]
;  (-> (fn[{: m : l}])
;      (reduce {:m {} :l {}}
;              col)))

;(fn partition [n col]
;  (reduce (fn [memo value]
;            (append memo value))
;          []
;          [(unpack (ipairs col))]))

; (s.pp (next {:a :b :c :d} nil))
; (s.pp (partition 3 (range 10)))

(comment
  (s.pp (reduce #(+ $1 $2) 0 [1 2 3 4]))
  (s.pp (map #(* $1 $1) [1 2 3 4]))
  (s.pp (filter #(= 0 (% $ 2)) [1 2 3 4]))

  (s.pp (range 10))
  (s.pp (range 0 10 2))
  (s.pp (range 10 15))
  (s.pp (range 15 10))
  (s.pp (range 15 10))

  nil)

{: inc : dec
 : append
 : range : irange
 : filter : map : reduce}
