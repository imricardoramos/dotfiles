# Print out Memory, cpu and load using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	type tmux-mem-cpu-load >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	stats=$(tmux-mem-cpu-load -t 0 -m 2 -g 0 -a 0 | awk '{print "#[bold]CPU#[nobold] " $2 "  #[bold]MEM#[nobold] " $1}')
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0
}
