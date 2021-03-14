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

(defn process-cell [{:keys [cell_type source]}]
  (str "# %%\n"
       (->> (case cell_type
              "markdown" (map #(str "# ~ " %) source)
              "code" source
              "")
            (apply str)
            (str/trim))
       "\n\n"))

(doseq [filename *command-line-args*]
  (let [[path ext] (split-filename filename)]
    (when (= ext "ipynb")
      (let [cells (-> filename
                      (slurp)
                      (json/parse-string true)
                      :cells)]
        (->> cells
             (map process-cell)
             (apply str)
             (spit (str path ".py")))))))

