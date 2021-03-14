#!/usr/bin/env bb

(require '[clojure.pprint :refer [pprint]]
         '[babashka.fs :as fs]
         '[babashka.process :as p])

(defn split-filename [filename]
  (let [directory (-> filename
                      (fs/absolutize)
                      (fs/parent))
        parts (-> filename
                  (fs/file-name)
                  (str/split #"\."))]
    [(->> parts
          (drop-last)
          (str/join ".")
          (fs/path directory))
     (-> parts
         (last)
         (str/lower-case))]))

(defn time->msecs
  ([pattern time]
   (time->msecs pattern time false))
  ([pattern time ms?]
   (let [parts (->> time
                    (re-matches pattern)
                    (rest)
                    (map #(Integer. %)))
         [h m s ms] parts]
     (+ (* h 1000 60 60)
        (* m 1000 60)
        (* s 1000)
        (if ms? ms 0)))))

(defn time->chapter [pattern start end]
  (let [start* (time->msecs pattern start)
        end* (time->msecs pattern end true)]
    (if-not (< start* end*)
      ""
      (str "[CHAPTER]\n"
           "TIMEBASE=1/1000\n"
           "START=" start* "\n"
           "END=" end*))))

(defmulti subs->chapters (fn [ext _] ext))

(defmethod subs->chapters "ass" [_ content]
  (->> content
       (re-seq #"(?m)^Dialogue:[^,]+,([^,]+),([^,]+),")
       (map #(let [[_ start end] %]
               (time->chapter #"(\d+):(\d+):(\d+)\.(\d+)"
                              start end)))))

(defmethod subs->chapters "srt" [_ content]
  (->> content
       (re-seq #"(?m)^\d+\r?\n([\d:,]+) --> ([\d:,]+)\r?\n")
       (map #(let [[_ start end] %]
               (time->chapter #"(\d+):(\d+):(\d+),(\d+)"
                              start end)))))

(doseq [filename *command-line-args*]
  (let [[path ext] (split-filename filename)]
    (->> filename
         (slurp)
         (subs->chapters ext)
         (str/join "\n")
         (str ";FFMETADATA1\n")
         (spit (str path ".ffmetadata")))))

