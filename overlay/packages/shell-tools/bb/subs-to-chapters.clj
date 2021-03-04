#!/usr/bin/env bb

(require '[clojure.pprint :refer [pprint]]
         '[babashka.fs :as fs]
         '[babashka.process :as p])

(defn clean-filename [filename]
  (let [directory (-> filename
                      (fs/absolutize)
                      (fs/parent))
        filename* (-> filename
                      (fs/file-name)
                      (str/split #"\.")
                      (drop-last)
                      (#(str/join "." %)))]
    (fs/path directory filename*)))

(defn time->msecs [time]
  (let [parts (->> time
                   (re-matches #"(\d+):(\d+):(\d+)\.(\d+)")
                   (rest)
                   (map #(Integer. %)))
        [h m s ms] parts]
    (+ (* h 1000 60 60)
       (* m 1000 60)
       (* s 1000))))
       ; ms)))

(defn ass->chapters [filename]
  (->> filename
       (slurp)
       (str/split-lines)
       (map #(re-matches #"Dialogue:[^,]+,([^,]+),([^,]+),.*" %))
       (remove nil?)
       (map #(let [[_ start end] %]
               (str "[CHAPTER]\nTIMEBASE=1/1000\n"
                    "START=" (time->msecs start) "\n"
                    "END=" (time->msecs end))))
       (str/join "\n")))

(doseq [filename *command-line-args*]
  (let [basename (clean-filename filename)]
    (spit (str basename ".ffmetadata")
          (str ";FFMETADATA1\n"
               (ass->chapters filename)))))
