#!/usr/bin/env bb

(require '[clojure.pprint :refer [pprint]]
         '[babashka.fs :as fs]
         '[babashka.process :as p])

(defn panic [data]
  (pprint data)
  (System/exit 1))

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

(defn wrap [s]
  (if-not s "" (str "[" s "]")))

(defn filename->mkv-info [filename]
  (-> ["mkvmerge" "-F" "json" "-i" filename]
      (p/process)
      (p/check)
      :out
      (slurp)
      (#(json/parse-string % true))))

(defn mkv-info->subtitles [data]
  (->> data
       :tracks
       (filter #(= (:type %) "subtitles"))
       (map #(let [subtitles %]
              (let [{:keys [id properties]} subtitles
                    {:keys [language track_name]} properties]
                (pprint [subtitles])
                [id language track_name])))))

(defn mkv-extract [filename id srt-filename]
  (-> ["mkvextract" "tracks" filename
       (str id ":" srt-filename)]
      (p/process {:out :inherit})
      (p/check)))

(doseq [filename *command-line-args*]
  (let [basename (clean-filename filename)]
    (doseq [[id language track-name] (-> filename
                                         (filename->mkv-info)
                                         (mkv-info->subtitles))]
      (let [srt-filename (str basename
                              (wrap language)
                              (wrap track-name)
                              ".srt")]
        (mkv-extract filename id srt-filename)))))
