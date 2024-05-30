run_segment() {
  cat ~/Sync/org/projects.org | grep '* IN-PROGRESS' | sed 's/\** IN-PROGRESS //g'
  return 0
}
